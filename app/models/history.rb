class History < ActiveRecord::Base
  belongs_to :camera
  
  has_attached_file(
    :image, 
    :styles => { 
      :gallery =>     ["75x75#",    :png], 
      :preview =>     ["320x240",   :png] 
    },
    :path => ":rails_root/public/paperclip/cameras/:id/:style/:basename.:extension",
    :url => "/paperclip/cameras/:id/:style/:basename.:extension"
  )
  
end
