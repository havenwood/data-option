# frozen_string_literal: true

require_relative 'test_helper'

class StringRepresentationTest < Minitest::Test
  include OptionTestHelper

  def test_some_to_s_and_inspect
    assert_equal 'Some[42]', @some.to_s
    assert_equal 'Some[42]', @some.inspect
  end

  def test_none_to_s_and_inspect
    assert_equal 'None', @none.to_s
    assert_equal 'None', @none.inspect
  end

  def test_complex_inspect
    complex = Some[[1, 2, 3]]

    assert_equal 'Some[[1, 2, 3]]', complex.inspect
  end

  def test_nested_inspect
    nested = Some[Some['hello']]

    assert_equal 'Some[Some["hello"]]', nested.inspect
  end
end
