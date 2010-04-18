require 'test_helper'

class CamerasControllerTest < ActionController::TestCase
  def test_index_only_shows_geolocalized_cameras
    5.times{ Factory(:camera) }
    3.times{ Factory(:camera, :lat => 10, :lng => 10)}
    
    get :index
    assert_template 'index'
    assert_equal( 3, assigns(:cameras).size )
  end
  
  def test_index_filtering_by_not_geolocalized
    5.times{ Factory(:camera) }
    3.times{ Factory(:camera, :lat => 10, :lng => 10)}
    
    get(
      :index,
      :geolocalized => 'false'
    )
    
    assert_template 'index'
    assert_equal( 5, assigns(:cameras).size )
  end
  
  def test_index_filtering_by_not_geolocalized_and_autoactivation
    5.times{ Factory(:camera) }
    3.times{ Factory(:camera, :lat => 10, :lng => 10)}
    camera = Factory(:camera)
    history = Factory(:history, :camera => camera)
    
    get(
      :index,
      :geolocalized => 'false',
      :autoactivation => 'true'
    )
    
    assert_template 'index'
    assert_equal( 6, assigns(:cameras).size )
    
    assert_match( camera.histories.last.image.url(:medium), @response.body )
  end
  
  def test_show
    get :show, :id => Factory(:camera)
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Camera.any_instance.stubs(:valid?).returns(false)
    post :create
    
    assert_not_nil( flash[:alert] )
    assert_template 'new'
  end
  
  def test_create_valid
    assert_difference "Camera.count", 1 do
      post(
        :create,
        :camera => {
          :name => 'new camera',
          :city => 'city camera'
        }   
      )   
    end

    assert_not_nil( flash[:notice] )
    assert_redirected_to camera_url(assigns(:camera))
  end
  
  def test_edit
    get :edit, :id => Factory(:camera)
    assert_template 'edit'
  end
  
  def test_update_invalid
    camera = Factory(:camera)
    Camera.any_instance.stubs(:valid?).returns(false)
    put :update, :id => camera
    
    assert_not_nil( flash[:alert] )
    assert_template 'edit'
  end
  
  def test_update_valid
    camera = Factory(:camera)
    
    put(
      :update, 
      :id => camera,
      :camera => {
        :name => 'new name',
        :city => 'new city'
      }
    )
    
    assert_not_nil( flash[:notice] )
    assert_redirected_to camera_url(assigns(:camera))
    
    camera.reload
    assert_equal( 'new name', camera.name )
    assert_equal( 'new city', camera.city )
  end
  
  def test_destroy
    camera = Factory(:camera)
    2.times { Factory(:history, :camera => camera) }
    
    assert_difference "Camera.count", -1 do
      assert_difference "History.count", -2 do
        delete(
          :destroy, 
          :id => camera
        )        
      end
    end

    assert_not_nil( flash[:notice] )
    assert_redirected_to cameras_url
    assert !Camera.exists?(camera.id)
  end
  
  def test_widget
    camera = Factory(:camera)
    
    get(
      :widget,
      :id => camera
    )
    
    assert_template :partial => '_widget'
  end
  
  def test_snapshot
    camera = Factory(:camera)
    history_201001010101 = Factory(:history, :date => '2010-01-01 01:01', :camera => camera)
    history_201001010201 = Factory(:history, :date => '2010-01-01 02:01', :camera => camera)
    history_201001010301 = Factory(:history, :date => '2010-01-01 03:01', :camera => camera)
    
    get( :snapshot, :camera_id => camera, :datetime => '201001010101', :size => 'medium' )

    # puts @response.body
    # {\"image_url\":\"/images/medium/missing.png\",\"datetime\":\"2010/01/01 01:01\"}    
    
    assert_match( "medium", @response.body)
    assert_match( "\"datetime\":\"01 Jan 03:01\"", @response.body)
    assert_equal( 'application/json', @response.content_type )
  end
  
  def test_snapshot_when_nil
    camera = Factory(:camera)
    history_201001010101 = Factory(:history, :date => '2010-01-01 01:01', :camera => camera)
    
    get( :snapshot, :camera_id => camera, :datetime => '200901010101', :size => 'medium' )

    # puts @response.body
    # <"{\"image_url\":\"/images/not_image_medium.jpg\",\"datetime\":\"2009/01/01 01:01\"}"
    
    assert_match( "medium", @response.body)
    assert_match( "\"datetime\":\"01 Jan 01:01\"", @response.body)
    assert_equal( 'application/json', @response.content_type )
  end
  
  def test_snapshot_with_datetime_param_actual_should_responses_with_last
    camera = Factory(:camera)
    history_201001010103 = Factory(:history, :date => '2010-01-01 01:03', :camera => camera)
    history_201001010101 = Factory(:history, :date => '2010-01-01 01:01', :camera => camera)
    
    get( :snapshot, :camera_id => camera, :datetime => 'actual', :size => 'medium' )

    # puts @response.body
    # <"{\"datetime\":\"2010/03/01 01:01\",\"image_url\":\"/images/medium/missing.png\"}">
    
    assert_match( "medium", @response.body)
    assert_match( "\"datetime\":\"01 Jan 03:03\"", @response.body)
    assert_equal( 'application/json', @response.content_type )
  end
end
