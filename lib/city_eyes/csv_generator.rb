require 'net/http'
require 'uri'

module CityEyes
  class CSVGenerator
    def self.csv_cameras_mad
      cameras_hashes = CityEyes::ScraperProcessor.extract_mad_cameras      
      
      # cleaning
      cameras_hashes.each do |camera_hash|
        camera_hash[:url].gsub!( '../', 'http://informo.munimadrid.es/informo/' )
        camera_hash[:url].gsub!( '_MDF', '' )
        camera_hash[:name].gsub!( "\n", '' )
        camera_hash[:name] = HTMLEntities.new.decode( camera_hash[:name] ).strip
        camera_hash[:name] = camera_hash[:name].titleize
        camera_hash[:name].gsub!( '   ', ' - ' )
        
        # TODO: modify this to hacking way
        camera_hash[:name].gsub!( 'Ñ', 'ñ' )
        camera_hash[:name].gsub!( 'Á', 'á' )
        camera_hash[:name].gsub!( 'É', 'é' )
        camera_hash[:name].gsub!( 'Í', 'í' )
        camera_hash[:name].gsub!( 'Ó', 'ó' )
        camera_hash[:name].gsub!( 'Ú', 'ú' )
      end
      
      result = "name, city, address, url_image\n"
      
      cameras_hashes.each do |camera_hash|
        result << 
          "\"#{camera_hash[:name]}\"" +
          ",\"Madrid\"" +
          ",\"#{camera_hash[:name]}\"" +
          ",\"#{camera_hash[:url]}\"\n"
      end
      
      file_path = "#{RAILS_ROOT}/#{APP_CONFIG[:db_cameras_path]}#{APP_CONFIG[:db_cameras_mad]}"
      
      FileUtils.mkpath( File.dirname( file_path ) )
      
      File.open( file_path, 'w' ) do |f|
        f.write( result )
      end
      
      puts "CSV Generator: db generated: #{file_path}"
      
      return file_path
    end
    
    def self.csv_cameras_bcn
      # the bcn cameras are in 27 pages
      page_nums = (1..27)
      url_template = "http://www.transit.bcn.es/transit/ca/cameres_pagina_XXX.html"
      
      result = "name, city, address, scraping_url_container, scraping_css_selector, notes\n"
      page_nums.each do |num|
        url = url_template.gsub('XXX', "#{num}")
        camera_bcn_details = CityEyes::ScraperProcessor.extract_camera_bcn_details( url )
        
        result <<
          "\"#{HTMLEntities.new.decode( camera_bcn_details[:name] ).strip}\"" +
          ",\"Barcelona\"" +
          ",\"#{HTMLEntities.new.decode( camera_bcn_details[:address] ).strip}\"" +
          ",\"#{url}\"" +
          ",\"#fotografia_camera > img\"" +
          ",\"#{HTMLEntities.new.decode( camera_bcn_details[:notes] ).strip}\"\n"
      end
      
      file_path = "#{RAILS_ROOT}/#{APP_CONFIG[:db_cameras_path]}#{APP_CONFIG[:db_cameras_bcn]}"
      
      FileUtils.mkpath( File.dirname( file_path ) )
      
      File.open( file_path, 'w' ) do |f|
        f.write( result )
      end
      
      puts "CSV Generator: db generated: #{file_path}"
      
      return file_path
    end
    
    def self.csv_all
      CityEyes::CSVGenerator.csv_cameras_mad
      CityEyes::CSVGenerator.csv_cameras_bcn
    end
  end
end