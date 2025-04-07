# frozen_string_literal: true

require_relative 'test_helper'

class FormatHelperTest < Minitest::Test
  include OptionTestHelper

  def test_pretty_print
    nested = Some[Some['hello']]

    assert_output(/Some\[\s*42\s*\]/) { PP.pp(@some) }
    assert_output(/None/) { PP.pp(@none) }
    assert_output(/Some\[\s*Some\[\s*"hello"\s*\]\s*\]/) { PP.pp(nested) }
  end

  def test_nested_none_pretty_print
    none_nested = Some[Some[None[]]]

    assert_output(/Some\[\s*Some\[\s*None\s*\]\s*\]/) { PP.pp(none_nested) }
  end
end
