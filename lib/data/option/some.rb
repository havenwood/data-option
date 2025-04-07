# frozen_string_literal: true

class Data
  module Option
    Some = Data.define(:value) do
      include Comparable

      def <=>(other)
        return 1 if other.is_a?(None)

        value <=> other.value
      end

      alias unwrap value
      alias unwrap_or_else value

      def unwrap_or(_default) = value
      def expect(_message) = value

      def and(other) = other.is_a?(Some) ? other : None[]
      def and_then = yield value
      def or(_other) = self
      def or_else = self
      def xor(other) = other.is_a?(Some) ? None[] : self

      def each
        yield value

        self
      end

      def map = Some[yield value]
      def filter = yield(value) ? self : None[]
      def flat_map(&) = map(&).flatten

      def flatten
        case value
        in None | Some
          value
        else
          self
        end
      end

      def map_or(_default) = yield value
      alias map_or_else map_or

      def some? = true
      def none? = false

      def some_and? = yield value
      alias none_or? some_and?

      def inspect = "Some[#{value.inspect}]"
      alias to_s inspect

      def pretty_print(pp)
        pp.group(1, 'Some[', ']') do
          pp.breakable('')
          case value
          in Some | None
            value.pretty_print(pp)
          else
            pp.pp(value)
          end
        end
      end
    end
  end
end
