require 'test_helper'

class CameraTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Camera.new.valid?
  end
  
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
end
