[![Gem Version](https://badge.fury.io/rb/schmitt-trigger.svg)](https://badge.fury.io/rb/schmitt-trigger)
[![Build Status](https://travis-ci.org/gaganawhad/schmitt-trigger.svg?branch=master)](https://travis-ci.org/gaganawhad/schmitt-trigger)
[![Code Climate](https://codeclimate.com/github/gaganawhad/schmitt-trigger/badges/gpa.svg)](https://codeclimate.com/github/gaganawhad/schmitt-trigger)
[![Test Coverage](https://codeclimate.com/github/gaganawhad/schmitt-trigger/badges/coverage.svg)](https://codeclimate.com/github/gaganawhad/schmitt-trigger/coverage)
[![Dependency Status](https://gemnasium.com/gaganawhad/schmitt-trigger.svg)](https://gemnasium.com/gaganawhad/schmitt-trigger)

# SchmittTrigger

This is a simple rubygem that implements a [Schmitt Trigger](https://en.wikipedia.org/wiki/Schmitt_trigger)

SchmittTrigger's have awesome [applications](https://en.wikipedia.org/wiki/Schmitt_trigger#Applications), but I haven't
actually come across a need for them in code, so this is purely for fun.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'schmitt-trigger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install schmitt-trigger

## Usage

To initialize a SchmittTrigger pass in the lower threshold and upper threshold when initializing in that order:

```ruby
schmitt_trigger = SchmittTrigger.new(-1, 1)
=> #<SchmittTrigger:0x007fd3bc32dda8 @lower_threshold=-1, @upper_threshold=1>
```

On a cold start it returns the `lower_threshold` as the output

```ruby
> schmitt_trigger.run(-5)
=> [-1]
> schmitt_trigger.run(0)
=> [-1]
```

When the output is at lower threshold it toggles to the upper threshold only after the signal reaches the upper
threshold.

```ruby
schmitt_trigger.output
=> -1
schmitt_trigger.run([-5, 0, 1, 2])
=> [-1, -1, 1, 1]
```

When the output is at upper threshold it toggles to the lower threshold only after the signal reaches the lower
threshold.

```ruby
> schmitt_trigger.output
=> 1
> schmitt_trigger.output
=> 1
> schmitt_trigger.run([4, 2, 0, -1, -5])
=> [1, 1, 1, -1, -1]
```




## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/schmitt-trigger. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
