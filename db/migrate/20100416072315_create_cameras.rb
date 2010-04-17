class CreateCameras < ActiveRecord::Migration
  def self.up
    create_table :cameras do |t|
      t.string  :name
      t.string  :city
      t.string  :address
      t.decimal :lng, :precision => 15, :scale => 10
      t.decimal :lat, :precision => 15, :scale => 10
      t.string  :url_image
      t.string  :scraping_url_container
      t.string  :scraping_css_selector
      t.integer :orientation
      t.text    :notes
      
      t.timestamps
    end
    
    add_index  :cameras, [:lat, :lng]
  end
  
  def self.down
    drop_table :cameras
  end
end
