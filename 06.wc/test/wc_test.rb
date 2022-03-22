require 'minitest/autorun'
require '..//wc'

class WCTest < Minitest::Test

  def test_wc_test1
    files = ["test1.rb"]
    pipeline = ""
    option = {"l"=>false}
    assert_equal "       3       9      66 test1.rb\n", word_count(files, pipeline, option)
  end

  def test_wc_get
    files = ["get.rb"]
    pipeline = ""
    option = {"l"=>false}
    assert_equal "       3       9      96 get.rb\n", word_count(files, pipeline, option)
  end

  def test_wc_cal
    files = ["cal.rb"]
    pipeline = ""
    option = {"l"=>false}
    assert_equal "      65     164    1756 cal.rb\n", word_count(files, pipeline, option)
  end

  def test_wc_ls5
    files = ["ls5.rb"]
    pipeline = ""
    option = {"l"=>false}
    assert_equal "     199     502    6300 ls5.rb\n", word_count(files, pipeline, option)
  end

  def test_wc_wc2
    files = ["wc2.rb"]
    pipeline = ""
    option = {"l"=>false}
    assert_equal "      63     188    2004 wc2.rb\n", word_count(files, pipeline, option)
  end

end