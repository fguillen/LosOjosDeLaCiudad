require 'open-uri'


module CityEyes
  class DustpanProcessor
    def self.pick_images

      Camera.all.each do |camera|        
        puts "XXX: processing camera: #{camera.name}, #{camera.city}"
        
        begin
          url_image = camera.check_url_image
        
          # img io from http://almosteffortless.com/2008/12/11/easy-upload-via-url-with-paperclip/
          io = open( URI.parse( url_image ) )
          def io.original_filename; base_uri.path.split('/').last; end        
        
          History.create!(
            :date => Time.now,
            :image => io,
            :camera => camera
          )
        
          puts "XXX: created image for camera: #{camera.name}, #{camera.city}"
        rescue Exception => e
          puts "XXX: ERROR creating image for camera: #{camera.name}, #{camera.city}"
          puts "e: #{e}"
        end
      end
      
    end
  end
end