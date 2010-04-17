class Camera < ActiveRecord::Base
  has_many :histories
  
  acts_as_mappable :default_units => :miles, 
                   :default_formula => :sphere, 
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng

  
  def check_url_image
    return url_image  unless url_image.nil? || url_image.empty?
    return CityEyes::ScraperProcessor.extract_image_url( scraping_url_container, scraping_css_selector )
  end
  

  def is_geolocalized?
    return ( !lat.nil? && (lat != 0) && !lng.nil? && (lng != 0) )
  end
end
