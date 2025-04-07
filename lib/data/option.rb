# frozen_string_literal: true

require_relative 'option/ext/kernel'
require_relative 'option/none'
require_relative 'option/refinement'
require_relative 'option/some'
require_relative 'option/version'

class Data
  module Option
    # Creates an Option from a value.
    # Returns `None` if the value is `nil`, otherwise returns `Some[value]`.
    def self.from(value)
      value.nil? ? None[] : Some[value]
    end
  end
end
