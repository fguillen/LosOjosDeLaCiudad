require 'test_helper'

class HistoryTest < ActiveSupport::TestCase
  def test_snapshot
    camera = Factory(:camera)
    history_201001010101 = Factory(:history, :date => '2010-01-01 01:01', :camera => camera)
    history_201001010201 = Factory(:history, :date => '2010-01-01 02:01', :camera => camera)
    history_201001010301 = Factory(:history, :date => '2010-01-01 03:01', :camera => camera)
    
    assert_equal( history_201001010101, History.snapshot( camera, '201001010101' ) )
    assert_equal( history_201001010201, History.snapshot( camera, '201001010201' ) )
    assert_equal( history_201001010301, History.snapshot( camera, '201001010301' ) )
    
    assert_equal( nil, History.snapshot( camera, '200901010101' ) )
    assert_equal( history_201001010301, History.snapshot( camera, '201101010301' ) )
    assert_equal( history_201001010101, History.snapshot( camera, '201001010131' ) )
  end
  
  def test_when_delete_delete_the_file_too
    camera = Factory(:camera)
    history = 
      History.create!(
        :camera => camera,
        :image => File.open( "#{RAILS_ROOT}/test/fixtures/webcam_image.jpg", 'r' ),
        :date => Time.now
      )
      
    image_path = history.image.path
    
    assert( File.exists?( image_path ) )
    
    history.destroy
    
    assert( !File.exists?( image_path ) )
  end
  
  def test_cleaner_days_ago
    camera = Factory(:camera)
    history_1_day_ago = Factory(:history, :date => 1.days.ago, :camera => camera)
    history_2_day_ago = Factory(:history, :date => 2.days.ago, :camera => camera)
    history_3_day_ago = Factory(:history, :date => 3.days.ago, :camera => camera)
    
    assert_difference "History.count", -2 do
      History.cleaner_days_ago( 2 )
    end
    
    assert History.exists?(history_1_day_ago.id)
    assert !History.exists?(history_2_day_ago.id)
    assert !History.exists?(history_3_day_ago.id)
  end
end
