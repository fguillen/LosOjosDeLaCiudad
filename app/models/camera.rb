class Camera < ActiveRecord::Base
  has_many :histories, :dependent => :destroy
  
  validates_presence_of :name, :city
  validates_uniqueness_of :name
  
  named_scope :not_geolocalized,  :conditions => "lat is null or lat = 0 or lng is null or lng = 0"
  named_scope :geolocalized,      :conditions => "lat is not null and lat != 0 and lng is not null and lng != 0"
  
  
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
  
  def self.filter( opts )
    puts "XXX: opts: #{opts}"
    
    scope = Camera.scoped({})
    scope = scope.geolocalized      if opts[:geolocalized] == 'true'
    scope = scope.not_geolocalized  if opts[:geolocalized] == 'false'
    scope = scope.scoped( :conditions => ["city = ?", opts[:city]] )  unless opts[:city].blank?
    scope
  end
end
