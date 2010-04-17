module CityEyes
  class CSVDigester
    
    #
    # if id_field exists on class_name the register is not proccessed
    #
    def self.digest( csv_path, class_name, id_field = nil )
      puts "XXX: digesting csv: #{csv_path}"
      objects_created = []
      
      ActiveRecord::Base.transaction do
        
        class_object = class_object.constantinize
        first_line = true
        attributes = []
      
        csv_file = File.open( csv_path, 'r' )
        csv_file.each do |line|
          
          if( first_line )
            attributes = line.split( ',' ).map { |attribute| attribute.strip.to_sym }
            first_line = false
          else
            values = line.split( ',' ).map { |value| value.strip }
            
            opts = {
              attribute[0] => value[0],
              attribute[1] => value[1],
              attribute[2] => value[2],
            }
            
            objects_created << class_object.create!( opts )
          end
        
        end
        
      end
    end
  end
end