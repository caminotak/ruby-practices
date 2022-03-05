# frozen_string_literal: true

require 'minitest/autorun'
require './wc'

class WCTest < Minitest::Test
  def test_wc_test3
    files = ['test1.rb']
    pipeline = ''
    option = { 'l' => false }
    assert_equal "      50     140    1007 test1.rb\n", word_count(files, pipeline, option)
  end
end
