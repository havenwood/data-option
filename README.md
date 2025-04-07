# Data::Option

This gem provides a `None` and `Some` with methods for creating, matching, and transforming optional values with Rust-like semantics.

## Installation

```bash
bundle add data-option
```

If you're not using Bundler, install the gem with:

```bash
gem install data-option
```

## Usage

### Basic Example

To use `Some[value]` and `None[]`, first `include Data::Option`.

```ruby
require 'data/option'

include Data::Option

def checked_division(dividend, divisor)
  if divisor.zero?
    None[]
  else
    Some[dividend / divisor]
  end
end

def try_division(dividend, divisor)
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
```

### Creating an Option Value

A `Some` or `None` can be created with multiple syntaxes:

```ruby
require 'data/option'

include Data::Option

Some[42]      # => Some[42]
None[]        # => None

Some.new(42)  # => Some[42]
None.instance # => None
```

Kernel#Option creates an Option from any value:

```ruby
require 'data/option'

Option(42)       # => Some[42]
Option(false)    # => Some[false]
Option(nil)      # => None
```

The equivalent class method `Option.from`:

```ruby
require 'data/option'

# Same behavior as the Kernel method
Option.from(42)    # => Some[42]
Option.from(false) # => Some[false]
Option.from(nil)   # => None
```

Enable Object#to_option via refinements:

```ruby
require 'data/option'

using Data::Option::Refinement

42.to_option    # => Some[42]
false.to_option # => Some[false]
nil.to_option   # => None

42.to_option.map(&:succ)   # => Some[43]
nil.to_option.map(&:succ)  # => None
```

### Predicates

Check the state of your Option values with predicate methods:

```ruby
require 'data/option'

include Data::Option

some = Some[42]
none = None[]

some.some? # => true
some.none? # => false
none.some? # => false
none.none? # => true

Some[42].some_and?(&:even?)  # => true (value exists and is even)
Some[41].some_and?(&:even?)  # => false (value exists but isn't even)
None[].some_and?(&:even?)    # => false (no value to check)

Some[42].none_or?(&:even?)   # => true (either None or predicate is true)
Some[41].none_or?(&:even?)   # => false (has value but predicate is false)
None[].none_or? { false }    # => true (None satisfies this predicate)
```

### Unwrapping

Extract values from an Option safely:

```ruby
require 'data/option'

include Data::Option

some = Some[42]
none = None[]

some.unwrap  # => 42
none.unwrap  #!> None::UnwrapError

some.unwrap_or(0)  # => 42
none.unwrap_or(0)  # => 0

some.unwrap_or_else { rand(100) }  # => 42
none.unwrap_or_else { rand(100) }  # => some random number

some.expect('Should contain value')  # => 42
none.expect('Missing expected value')  #!> None::UnwrapError
```

### Enumeration and Transformation

Map, filter, and transform Option values:

```ruby
require 'data/option'

include Data::Option

Some[42].each { |value| puts value }  # prints 42
None[].each { |value| puts value }    # no output

Some[42].map { |n| n + 1 }  # => Some[43]
None[].map { |n| n + 1 }    # => None

Some[42].filter(&:even?)    # => Some[42]
Some[41].filter(&:even?)    # => None
None[].filter { true }      # => None

Some[42].flat_map { |n| Some[n + 1] }  # => Some[43]
Some[42].flat_map { |_| None[] }       # => None
None[].flat_map { |n| Some[n + 1] }    # => None

Some[Some[42]].flatten  # => Some[42]
Some[None[]].flatten    # => None
Some[42].flatten        # => Some[42]
None[].flatten          # => None

Some[42].map_or(0) { |n| n + 1 }  # => 43
None[].map_or(0) { |n| n + 1 }    # => 0

Some[42].map_or_else(-> { rand(100) }) { |n| n + 1 }  # => 43
None[].map_or_else(-> { rand(100) }) { |n| n + 1 }    # => random number
```

### Logical Operations

Combine Option values with logical operations:

```ruby
require 'data/option'

include Data::Option

Some[1].and(Some[2])  # => Some[2]
Some[1].and(None[])   # => None
None[].and(Some[1])   # => None
None[].and(None[])    # => None

Some[1].and_then { |n| Some[n + 1] }  # => Some[2]
Some[1].and_then { |_| None[] }       # => None
None[].and_then { |n| Some[n + 1] }   # => None

Some[1].or(Some[2])  # => Some[1]
Some[1].or(None[])   # => Some[1]
None[].or(Some[2])   # => Some[2]
None[].or(None[])    # => None

Some[1].or_else { Some[2] }  # => Some[1]
None[].or_else { Some[2] }   # => Some[2]
None[].or_else { None[] }    # => None

Some[1].xor(Some[2])  # => None
Some[1].xor(None[])   # => Some[1]
None[].xor(Some[2])   # => Some[2]
None[].xor(None[])    # => None
```

### String Representation and Formatting

Options provide clear string representations:

```ruby
require 'data/option'

include Data::Option

Some[42].to_s     # => "Some[42]"
Some[42].inspect  # => "Some[42]"
None[].to_s       # => "None"
None[].inspect    # => "None"

Some[[1, 2, 3]].inspect         # => "Some[[1, 2, 3]]"
Some[Some["hello"]].inspect     # => "Some[Some[\"hello\"]]"

require 'pp'
PP.pp(Some[42])             # Some[ 42 ]
PP.pp(Some[Some[None[]]])   # Some[ Some[ None ] ]
```

### Comparison and Sorting

`Some` and `None` are comparable and sortable. `None` is considered lower than all `Some` values, and `Some` values are ordered by their contained values:

```ruby
require 'data/option'

include Data::Option

Some[1] < Some[2]  # => true
Some[2] > Some[1]  # => true
Some[1] == Some[1] # => true

Some[1] > None[]   # => true
None[] < Some[1]   # => true

[Some[3], None[], Some[1], Some[2]].sort  # => [None[], Some[1], Some[2], Some[3]]
```

### Method Chaining

Chain operations for elegant functional transformations:

```ruby
require 'data/option'

include Data::Option

Option(42)
  .map { |it| it * 10 }               # => Some[420]
  .flat_map { |it| Option(it - 440) } # => Some[-20]
  .filter(&:positive?)                # => None
  .map { |it| it * 10 }               # => None
  .unwrap_or(99)                      # => 99
```

### Method Overview

`Some` and `None` both respond to a wide range of utility methods that cover common functional programming patterns:

- Checking: `some?`, `none?`, `some_and?`, `none_or?`
- Unwrapping: `unwrap`, `unwrap_or`, `unwrap_or_else`, `expect`
- Transforming: `map`, `flat_map`, `filter`, `flatten`, `map_or`, `map_or_else`, `each`
- Combining: `and`, `and_then`, `or`, `or_else`, `xor`
- Formatting: `to_s`, `inspect`
- Comparison: `<=>`, `==`, `<`, `>`, etc.

See Rust's Option [Method overview](https://doc.rust-lang.org/std/option/#method-overview) for background and inspiration for these methods.
