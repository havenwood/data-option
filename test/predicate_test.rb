# frozen_string_literal: true

require_relative 'test_helper'

class PredicateTest < Minitest::Test
  include OptionTestHelper

  def test_some_predicates_for_some
    assert_predicate @some, :some?
    refute_predicate @some, :none?
  end

  def test_some_predicates_for_none
    refute_predicate @none, :some?
    assert_predicate @none, :none?
  end

  def test_some_and
    assert(@some.some_and?(&:even?))
    refute(Some[41].some_and?(&:even?))
    refute(@none.some_and? { |_value| true })
  end

  def test_none_or
    assert(@some.none_or?(&:even?))
    refute(Some[41].none_or?(&:even?))
    assert(@none.none_or? { |_value| false })
  end
end
