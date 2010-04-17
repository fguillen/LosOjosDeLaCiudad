require 'test_helper'

class ScraperProcessorTest < ActiveSupport::TestCase
  def test_extract_image_url_from_bcn_camera
    CityEyes::ScraperProcessor.extract_image_url( 
      'http://www.bcn.cat/transit/es/cameres_pagina_26.html', 
      '#fotografia_camera > img'
    )
  end
  
  def test_extract_image_url_from_mad_camera
    CityEyes::ScraperProcessor.extract_image_url( 
      'http://www.dgt.es/portal/es/informacion_carreteras/camaras_trafico/camaras005.htm', 
      '#fotografia_camera > img'
    )
  end
  
  def test_extract_mad_cameras
    cameras_mad_hashes = CityEyes::ScraperProcessor.extract_mad_cameras
    
    assert_equal( 169, cameras_mad_hashes.size )
    
    assert_equal( "\nPLAZA DE CASTILLA - NORTE", cameras_mad_hashes[0][:name] )
    assert_equal( '../Camaras/Camara00001_MDF.jpg', cameras_mad_hashes[0][:url] )
  end
  
  def test_extract_camera_bcn_details
    result = CityEyes::ScraperProcessor.extract_camera_bcn_details( 'http://www.transit.bcn.es/transit/ca/cameres_pagina_3.html' )
    
    assert_equal( 'Arag&oacute; - Passeig de Gr&agrave;cia', result[:name] )
    assert_equal( 'Arag&oacute; - Passeig de Gr&agrave;cia', result[:address] )
    assert_equal( 'Orientaci&oacute;:Arag&oacute;, sentit Llobregat', result[:notes] )
  end
end