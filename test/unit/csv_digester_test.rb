require 'test_helper'

class CSVDigesterTest < ActiveSupport::TestCase
  def test_digest
    CityEyes::CSVDigester.digest( "#{RAILS_ROOT}/test/fixtures/db_cameras/cameras_mad_portion.csv", "Camera", :name )
  end
end