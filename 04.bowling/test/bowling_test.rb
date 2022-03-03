# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/bowling'

class BowlingTest < Minitest::Test
  def test_throw1
    throws = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'
    assert_equal 139, sum_scores(throws)
  end

  def test_throw2
    throws = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X'
    assert_equal 164, sum_scores(throws)
  end

  def test_throw3
    throws = '0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4'
    assert_equal 107, sum_scores(throws)
  end

  def test_throw4
    throws = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0'
    assert_equal 134, sum_scores(throws)
  end

  def test_throw5
    throws = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8'
    assert_equal 144, sum_scores(throws)
  end

  def test_throw6
    throws = 'X,X,X,X,X,X,X,X,X,X,X,X'
    assert_equal 300, sum_scores(throws)
  end
end
