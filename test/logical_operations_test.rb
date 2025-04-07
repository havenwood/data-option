# frozen_string_literal: true

require_relative 'test_helper'

class LogicalOperationsTest < Minitest::Test
  include OptionTestHelper

  def test_and_with_some
    assert_equal Some[2], Some[1].and(Some[2])
    assert_equal None[], Some[1].and(None[])
  end

  def test_and_with_none
    assert_equal None[], None[].and(Some[1])
    assert_equal None[], None[].and(None[])
  end

  def test_and_then
    assert_equal(Some[2], Some[1].and_then { Some[2] })
    assert_equal(None[], Some[1].and_then { None[] })
    assert_equal(None[], None[].and_then { Some[2] })
  end

  def test_or_with_some
    assert_equal Some[1], Some[1].or(Some[2])
    assert_equal Some[1], Some[1].or(None[])
  end

  def test_or_with_none
    assert_equal Some[2], None[].or(Some[2])
    assert_equal None[], None[].or(None[])
  end

  def test_or_else
    assert_equal(Some[1], Some[1].or_else { Some[2] })
    assert_equal(Some[2], None[].or_else { Some[2] })
    assert_equal(None[], None[].or_else { None[] })
  end

  def test_xor_with_some
    assert_equal None[], Some[1].xor(Some[2])
    assert_equal Some[1], Some[1].xor(None[])
  end

  def test_xor_with_none
    assert_equal Some[2], None[].xor(Some[2])
    assert_equal None[], None[].xor(None[])
  end
end
