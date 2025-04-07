# frozen_string_literal: true

require_relative 'test_helper'

class UnwrappingTest < Minitest::Test
  include OptionTestHelper

  def test_unwrap
    assert_equal 42, @some.unwrap
    assert_raises(None::UnwrapError) { @none.unwrap }
  end

  def test_unwrap_or
    assert_equal 42, @some.unwrap_or(0)
    assert_equal 0, @none.unwrap_or(0)
  end

  def test_unwrap_or_else
    assert_equal(42, @some.unwrap_or_else { 0 })
    assert_equal(0, @none.unwrap_or_else { 0 })
  end

  def test_expect
    assert_equal 42, @some.expect('should not fail')
    error = assert_raises(None::UnwrapError) { @none.expect('custom message') }
    assert_equal 'custom message', error.message
  end
end
