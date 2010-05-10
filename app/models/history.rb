class History < ActiveRecord::Base
  belongs_to :camera
  
  validates_presence_of :camera_id
  validates_presence_of :date
  
  has_attached_file(
    :image, 
    :styles => { 
      :small =>     ["150x110",   :jpg], 
      :medium =>    ["240x176",   :jpg],
      :large =>     ["320x240",   :jpg] 
    },
    :convert_options => { 
      :all => '-quality 60 -strip'
    },
    :path => ":rails_root/public/paperclip/cameras/:camera_id/histories/:id/:style/:basename.:extension",
    :url => "/paperclip/cameras/:camera_id/histories/:id/:style/:basename.:extension"
  )
  
  
  def self.snapshot( camera, date_in_compres_format )
    camera.histories.find(:first, :conditions => ["date <= ?", Time.parse( date_in_compres_format )], :order => 'date desc')
  end
  
  
  def self.cleaner_days_ago( days_ago )
    puts "XXX: cleaning histories #{days_ago} days ago."
    
    histories_to_clean = 
      History.find(
        :all, 
        :conditions => ["date <= ?", days_ago.days.ago]
      )
    
    histories_to_clean.each do |history|
      history.destroy
    end
    
    puts "XXX: #{histories_to_clean.size} histories destroyed"
  end
end
