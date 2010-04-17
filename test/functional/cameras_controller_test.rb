require 'test_helper'

class CamerasControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Camera.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Camera.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Camera.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to camera_url(assigns(:camera))
  end
  
  def test_edit
    get :edit, :id => Camera.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Camera.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Camera.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Camera.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Camera.first
    assert_redirected_to camera_url(assigns(:camera))
  end
  
  def test_destroy
    camera = Camera.first
    delete :destroy, :id => camera
    assert_redirected_to cameras_url
    assert !Camera.exists?(camera.id)
  end
end
