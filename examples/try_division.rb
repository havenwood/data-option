# frozen_string_literal: true

require 'data/option'

include Data::Option

# An integer division that doesn't `raise ZeroDivisionError`
def checked_division(dividend, divisor)
  if divisor.zero?
    # Failure is represented as the `None` variant
    None[]
  else
    # Result is wrapped in a `Some` variant
    Some[dividend / divisor]
  end
end

# This function handles a division that may not succeed
def try_division(dividend, divisor)
  # `Option` values can be pattern matched, just like other enums
  case checked_division(dividend, divisor)
  in None
    puts "#{dividend} / #{divisor} failed!"
  in Some(quotient)
    puts "#{dividend} / #{divisor} = #{quotient}"
  end
end

try_division(4, 2)
# >> 4 / 2 = 2
try_division(1, 0)
# >> 1 / 0 failed!
