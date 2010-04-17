class History < ActiveRecord::Base
  belongs_to :camera
  
  has_attached_file(
    :image, 
    :styles => { 
      :small =>     ["150x110",   :png], 
      :medium =>    ["240x176",   :png],
      :large =>     ["320x240",   :png] 
    },
    :path => ":rails_root/public/paperclip/cameras/:id/:style/:basename.:extension",
    :url => "/paperclip/cameras/:id/:style/:basename.:extension"
  )
  
end
