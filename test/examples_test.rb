# frozen_string_literal: true

require_relative 'test_helper'

class ExamplesTest < Minitest::Test
  include OptionTestHelper

  def test_checked_division
    checked_division = lambda do |dividend, divisor|
      if divisor.zero?
        None[]
      else
        Some[dividend / divisor]
      end
    end

    assert_equal Some[2], checked_division.call(4, 2)
    assert_equal None[], checked_division.call(1, 0)
  end

  def test_readme_chain_example
    result = Option(42)
             .map { |it| it * 10 }
             .flat_map { |it| Option(it - 440) }
             .filter(&:positive?)
             .map { |it| it * 10 }
             .unwrap_or(99)

    assert_equal 99, result
  end
end
