require 'open-uri'


module CityEyes
  class DustpanProcessor
    def self.pick_images
      Camera.all.each do |camera|
        
        puts "XXX: processing camera: #{camera.name}"
        
        url_image = camera.check_url_image
        
        puts "XXX: url_image: #{url_image}"
        # url_image = CGI::escape( url_image )
        # 
        # puts "XXX: url_image_scaped: #{url_image}"
        
        # img io from http://almosteffortless.com/2008/12/11/easy-upload-via-url-with-paperclip/
        io = open( URI.parse( url_image ) )
        def io.original_filename; base_uri.path.split('/').last; end        
        
        History.create!(
          :date => Time.now,
          :image => io,
          :camera => camera
        )
        
        puts "XXX: created image: #{url_image}"
      end
      
    end
  end
end