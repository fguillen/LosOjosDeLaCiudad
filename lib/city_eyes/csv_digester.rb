module CityEyes
  class CSVDigester
    
    #
    # if id_field exists on class_name the register is not proccessed
    #
    def self.digest( csv_path, class_name, id_field = nil )
      puts "XXX: digesting csv: #{csv_path}"
      objects_created = []
      
      ActiveRecord::Base.transaction do
        
        class_object = class_name.constantize
        first_line = true
        attributes = []
      
        csv_file = File.open( csv_path, 'r' )
        csv_file.each do |line|
          
          if( first_line )
            attributes = line.split( ',' ).map { |attribute| attribute.strip.to_sym }
            first_line = false
          else
            values = line.split( '","' ).map { |value| value.gsub( '"', '' ).strip }
            
            # build opts
            opts = {}
            (0..(attributes.size-1)).each do |i|
              opts[attributes[i]] = values[i]
            end
            
            object_created = nil
            if( !id_field.nil? )
              object_created = class_object.send( "find_by_#{id_field}", opts[id_field.to_sym] ) 
            end
            
            # create or update
            if( object_created )
              object_created.update_attributes( opts )
              objects_created << object_created
            else
              objects_created << class_object.create!( opts )
            end

          end
        
        end
        
        return objects_created
      end
    end
    
    def self.digest_all
      db_cameras_path = APP_CONFIG[:db_cameras_path]
      
      puts "XXX: digesting all csv on: #{db_cameras_path}"
      
      objects_created = []
      
      Dir.glob( File.join( RAILS_ROOT, db_cameras_path , "*.csv" ) ).each do |file_name|
        objects_created = objects_created + CityEyes::CSVDigester.digest( file_name, 'Camera', 'name' )
      end 
      
      return objects_created
    end
  end
end