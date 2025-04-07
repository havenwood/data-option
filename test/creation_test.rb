# frozen_string_literal: true

require_relative 'test_helper'

class CreationTest < Minitest::Test
  include OptionTestHelper

  def test_some_creation
    assert_instance_of Some, @some
    assert_equal 42, @some.value
  end

  def test_none_creation
    assert_instance_of None, @none
    assert_same None.instance, @none
  end

  def test_option_from
    assert_instance_of Some, Data::Option.from(42)
    assert_instance_of Some, Data::Option.from(false)
    assert_instance_of None, Data::Option.from(nil)
  end

  def test_kernel_option
    assert_instance_of Some, Option(42)
    assert_instance_of Some, Option(false)
    assert_instance_of None, Option(nil)
  end

  def test_option_with_nil_and_false
    assert_instance_of Some, Option(false)
    assert_instance_of None, Option(nil)
  end
end
