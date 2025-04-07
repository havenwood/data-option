# frozen_string_literal: true

require_relative 'test_helper'

class EnumerationTest < Minitest::Test
  include OptionTestHelper

  def test_each_some
    result = []
    returned = @some.each { |value| result << value }

    assert_equal [42], result
    assert_equal @some, returned
  end

  def test_each_none
    result = []
    returned = @none.each { |value| result << value }

    assert_empty result
    assert_equal @none, returned
  end

  def test_map
    assert_equal(Some[43], @some.map { |value| value + 1 })
    assert_equal(None[], @none.map { |value| value + 1 })
  end

  def test_filter
    assert_equal(@some, @some.filter(&:even?))
    assert_equal(None[], Some[41].filter(&:even?))
    assert_equal(None[], @none.filter { |_value| true })
  end

  def test_flat_map_regular_value
    result = @some.flat_map { |value| [value + 1] }

    assert_instance_of Some, result
    assert_equal [43], result.value
  end

  def test_flat_map_option_value
    assert_equal Some[42], Some[Some[42]].flatten
    assert_equal None[], Some[None[]].flatten
    assert_equal(None[], @none.flat_map { |value| [value] })
  end

  def test_flatten_nested_option
    assert_equal Some[42], Some[Some[42]].flatten
    assert_equal None[], Some[None[]].flatten
  end

  def test_flatten_non_nested_option
    assert_equal @some, @some.flatten
    assert_equal @none, @none.flatten
  end

  def test_map_or
    assert_equal 43, @some.map_or(0) { |value| value + 1 }
    assert_equal 0, @none.map_or(0) { |value| value + 1 }
  end

  def test_map_or_else
    assert_equal 43, @some.map_or_else(-> { 0 }) { |value| value + 1 }
    assert_equal 0, @none.map_or_else(-> { 0 }) { |_value| raise 'Should not be called' }
  end
end
