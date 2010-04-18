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
end
