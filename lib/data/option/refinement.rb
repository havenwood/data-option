# frozen_string_literal: true

class Data
  module Option
    module Refinement
      refine Object do
        def to_option = Option::Some[self]
      end

      refine NilClass do
        def to_option = Option::None[]
      end
    end
  end
end
