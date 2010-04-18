require 'test_helper'

class CSVDigesterTest < ActiveSupport::TestCase
  def test_digest_cameras_mad
    cameras = []
    assert_difference "Camera.count", 5 do
      cameras = CityEyes::CSVDigester.digest( "#{RAILS_ROOT}/test/fixtures/db_cameras/cameras_mad_portion.csv", "Camera", 'name' )      
    end

    assert_equal( 'Plaza De Castilla - Norte', cameras[0].name )
    assert_equal( 'Madrid', cameras[0].city )
    assert_equal( 'Plaza De Castilla - Norte', cameras[0].address )
    assert_equal( 'http://informo.munimadrid.es/informo/Camaras/Camara00001.jpg', cameras[0].url_image )
  end
  
  def test_digest_cameras_bcn
    cameras = []
    assert_difference "Camera.count", 4 do
      cameras = CityEyes::CSVDigester.digest( "#{RAILS_ROOT}/test/fixtures/db_cameras/cameras_bcn_portion.csv", "Camera", 'name' )      
    end

    assert_equal( 'Plaça Catalunya', cameras[0].name )
    assert_equal( 'Barcelona', cameras[0].city )
    assert_equal( 'Plaça Catalunya', cameras[0].address )
    assert_equal( nil, cameras[0].url_image )
    assert_equal( 'http://www.transit.bcn.es/transit/ca/cameres_pagina_1.html', cameras[0].scraping_url_container )
    assert_equal( '#fotografia_camera > img', cameras[0].scraping_css_selector )
  end
  
  def test_on_digest_if_id_already_exists_update
    camera = Factory(:camera, 'name' => 'name wadus')
    assert_equal( 'name wadus', camera.name )
    assert_not_equal( 'city wadus', camera.city )
    assert_not_equal( 'address wadus', camera.address )
    assert_not_equal( 'http://wadus.url', camera.url_image )

    cameras = []
    assert_difference "Camera.count", 0 do
      cameras = CityEyes::CSVDigester.digest( "#{RAILS_ROOT}/test/fixtures/db_cameras/cameras_mad_one.csv", "Camera", 'name' )
    end
    
    camera.reload
    assert_equal( 'name wadus', camera.name )
    assert_equal( 'city wadus', camera.city )
    assert_equal( 'address wadus', camera.address )
    assert_equal( 'http://wadus.url', camera.url_image )
    
    assert_equal( camera, cameras[0] )
    assert_equal( 1, cameras.size )
  end
  
  def test_digest_all
    APP_CONFIG.expects( '[]' ).with( :db_cameras_path ).returns( 'test/fixtures/db_cameras_to_digester_all_test/' )
    
    CityEyes::CSVDigester.expects( :digest ).with( "#{RAILS_ROOT}/test/fixtures/db_cameras_to_digester_all_test/cameras_bcn.csv", "Camera", "name" ).returns( [1,2] )
    CityEyes::CSVDigester.expects( :digest ).with( "#{RAILS_ROOT}/test/fixtures/db_cameras_to_digester_all_test/cameras_mad.csv", "Camera", "name" ).returns( [3,4] )
    
    assert_equal( [1,2,3,4], CityEyes::CSVDigester.digest_all )
  end
end