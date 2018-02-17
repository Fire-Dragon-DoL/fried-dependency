# Fried::Dependency

Easily define object dependencies and inject them

## Installation

Add this line to your application's Gemfile:

```ruby
gem "fried-dependency"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fried-dependency

## Usage

Define object dependencies:

```ruby
class A
end

class B
end

class D
end

class C
  include Fried::Dependency::Loose

  dependency :a, A
  dependency :b, B

  def call
    puts a.inspect
    puts b.inspect
  end
end

c = C.new
c.call # Prints <A...> and  <B...>

# No check is performed on the type with `Loose`
c = C.new(a: D.new)
c.call # Prints <D...> and <B...>
```

Define **strict** object dependencies

```ruby
class A
  def foo
  end
end

class B
end

class D
end

class C
  include Fried::Dependency::Strict

  dependency :a, A
  dependency :b, B

  def call
    puts a.inspect
    puts b.inspect
  end
end

c = C.new
c.call # Prints <A...> and  <B...>

# Passed dependencies must match interface (`InterfaceOf` of fried-typings)
c = C.new(a: D.new) # raises TypeError
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Fire-Dragon-DoL/fried-dependency.
