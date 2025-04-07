# frozen_string_literal: true

require_relative 'test_helper'

class ComparisonTest < Minitest::Test
  include OptionTestHelper

  def test_comparison_between_some
    assert_operator Some[1], :<, Some[2]
    assert_operator Some[2], :>, Some[1]
    a = Some[1]
    b = Some[1].dup

    assert_equal 0, a.<=>(b)
  end

  def test_comparison_between_some_and_none
    assert_operator Some[1], :>, None[]
    assert_operator None[], :<, Some[1]
  end

  def test_comparison_between_none
    a = None[]
    b = None[]

    assert_equal 0, a.<=>(b)
  end
end
