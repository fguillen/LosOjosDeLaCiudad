module CityEyes
  class ScraperProcessor
    def self.extract_image_url( scraping_url_container, scraping_css_selector )
      scraper = Scraper.define do  
        process scraping_css_selector, :img_src => "@src"  
        result :img_src
      end  
        
      uri = URI.parse( scraping_url_container )  
      
      scraper.scrape( uri )
    end
    
    def self.extract_mad_cameras
      scraper = Scraper.define do  
        array :cameras  
        process "table.tabla td", :cameras => Scraper.define {  
          process "img", :url => "@src"
          process "> div", :name => :text
          result :url, :name  
        }  
        result :cameras
      end
      
      # download html
      url = URI.parse('http://informo.munimadrid.es/')
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.get('/informo/rutas/ruta0.php')
      }
      mad_cameras_html = res.body
      
      # cleaning html
      mad_cameras_html.gsub!( '<div style="font-size:11px" style="font-family:Arial, Helvetica, sans-serif" style="color:#999999" </div>', '' )
      
      # uri = URI.parse( 'http://informo.munimadrid.es/informo/rutas/ruta0.php' )  
      
      # scraping
      scraper.scrape( mad_cameras_html )
    end
    
    def self.extract_camera_bcn_details( url )
      scraper = Scraper.define do  
        process '#fotografia_camera > h3', :name => :text
        process '#fotografia_camera > h3', :address => :text
        process '#fotografia_camera > ul > li:last-child', :notes => :text
        result :name, :address, :notes
      end  
        
      uri = URI.parse( url )  
      
      scraper.scrape( uri )
    end
  end
end