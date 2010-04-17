require 'test_helper'

class CSVGeneratorTest < ActiveSupport::TestCase
  def test_csv_cameras_mad
    file_path = "#{RAILS_ROOT}/#{APP_CONFIG[:db_cameras_path]}#{APP_CONFIG[:db_cameras_mad]}"
    
    FileUtils.rm( file_path, :force => true )
    CityEyes::CSVGenerator.csv_cameras_mad
    assert( File.exists?( file_path ) )
    
    assert_match( 
      File.read( "#{RAILS_ROOT}/test/fixtures/db_cameras/cameras_mad_portion.csv"), 
      File.read( file_path )
    )
  end
  
  def test_csv_cameras_bcn
    file_path = "#{RAILS_ROOT}/#{APP_CONFIG[:db_cameras_path]}#{APP_CONFIG[:db_cameras_bcn]}"
    
    FileUtils.rm( file_path, :force => true )
    CityEyes::CSVGenerator.csv_cameras_bcn    
    assert( File.exists?( file_path ) )
    
    assert_match( 
      File.read( "#{RAILS_ROOT}/test/fixtures/db_cameras/cameras_bcn_portion.csv"), 
      File.read( file_path )
    )
  end
end