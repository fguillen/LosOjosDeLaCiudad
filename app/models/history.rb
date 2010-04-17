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
      :small =>   '-quality 60',
      :medium =>  '-quality 60',
      :large =>   '-quality 60',
    },
    :path => ":rails_root/public/paperclip/cameras/:camera_id/histories/:id/:style/:basename.:extension",
    :url => "/paperclip/cameras/:camera_id/histories/:id/:style/:basename.:extension"
  )
  
end
