# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/proveit'
require 'data/option'

module OptionTestHelper
  include Data::Option

  def setup
    @some = Some[42]
    @none = None[]
  end
end
