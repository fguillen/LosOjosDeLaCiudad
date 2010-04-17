require 'test_helper'

class DustpanProcessorTest < ActiveSupport::TestCase
  def test_pick_images
    camera_bcn = 
      Factory(
        :camera,
        :url_container => 'http://www.bcn.cat/transit/es/cameres_pagina_26.html',
        :css_selector => '#fotografia_camera > img'
      )
      
    camera_a1 =
      Factory(
        :camera,
        :url_image => 'http://www.dgt.es/camaras/camara-2700001-231.jpg'
    )
    
    CityEyes::DustpanProcessor.pick_images
    
  end
end
