require 'test_helper'

class CameraTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Camera.new.valid?
  end
end
