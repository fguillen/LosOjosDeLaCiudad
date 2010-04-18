require 'test_helper'

class CameraTest < ActiveSupport::TestCase
  
  def test_is_geolocalized
    camera = Factory(:camera, :lat => nil, :lng => nil )
    assert_equal( false, camera.is_geolocalized? )

    camera.lat = 10;
    assert_equal( false, camera.is_geolocalized? )    
    
    camera.lng = 0.0;
    assert_equal( false, camera.is_geolocalized? )
    
    camera.lng = 1.0;
    assert_equal( true, camera.is_geolocalized? )
  end
  
  def test_filter
    camera_geolocalized_madrid = Factory(:camera, :city => 'Madrid', :lat => 10, :lng => 10)
    camera_not_geolocalized_madrid = Factory(:camera, :city => 'Madrid', :lat => nil)
    camera_geolocalized_barcelona = Factory(:camera, :city => 'Barcelona', :lat => 10, :lng => 10)
    
    assert_equal( [camera_geolocalized_madrid], Camera.filter( {:geolocalized => 'true', :city => 'Madrid'} ) )
    assert_equal( [camera_geolocalized_barcelona], Camera.filter( {:geolocalized => 'true', :city => 'Barcelona'} ) )
    assert_equal( [camera_geolocalized_madrid, camera_geolocalized_barcelona], Camera.filter( {:geolocalized => 'true'} ) )
    
    assert_equal( [camera_not_geolocalized_madrid], Camera.filter( {:geolocalized => 'false', :city => 'Madrid'} ) )
    assert_equal( [], Camera.filter( {:geolocalized => 'false', :city => 'Barcelona'} ) )
    
    assert_equal( [camera_not_geolocalized_madrid], Camera.filter( {:geolocalized => 'false'} ) )
  end
end
