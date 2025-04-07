# frozen_string_literal: true

require 'singleton'

class Data
  module Option
    None = Data.define
    class None
      class UnwrapError < StandardError
        def initialize(message = 'cannot unwrap a `None` value') = super
      end

      include Comparable
      include Singleton

      def <=>(other) = other.is_a?(Some) ? -1 : 0

      class << self
        alias [] instance
      end

      def unwrap = raise UnwrapError
      def unwrap_or_else = yield

      def unwrap_or(default) = default
      def expect(message) = raise UnwrapError, message

      def and(_other) = self
      def and_then = self
      def or(other) = other.is_a?(Some) ? other : self
      alias or_else unwrap_or_else
      alias xor or

      def each = self
      alias map each
      alias filter each
      alias flat_map each
      alias flatten each

      alias map_or unwrap_or
      def map_or_else(default) = default.call

      def some? = false
      def none? = true

      alias some_and? some?
      alias none_or? none?

      def inspect = 'None'
      alias to_s inspect

      def pretty_print(pp) = pp.text(inspect)
    end
  end
end
