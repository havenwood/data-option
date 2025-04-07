# frozen_string_literal: true

require_relative 'test_helper'

class RefinementTest < Minitest::Test
  include OptionTestHelper

  using Data::Option::Refinement

  def test_to_option_with_regular_object
    assert_instance_of Some, 42.to_option
    assert_equal 42, 42.to_option.value
  end

  def test_to_option_with_false
    assert_instance_of Some, false.to_option
    refute false.to_option.value
  end

  def test_to_option_with_nil
    assert_instance_of None, nil.to_option
  end

  def test_to_option_with_complex_objects
    obj = Object.new

    assert_equal obj, obj.to_option.value

    array = [1, 2, 3]

    assert_equal array, array.to_option.value
  end

  def test_to_option_chaining
    assert_equal 43, 42.to_option.map { |n| n + 1 }.value
    assert_equal None[], (nil.to_option.map { |n| n + 1 })
  end
end
