# MultiOpQueue

Pure Ruby implementation of a Queue (from ruby-2.0.0) which also support multi-value operations while retaining the lock that protects the queue

### Example
`pop_up_to` will return an array of values from the queue (up to the number specified) with only a single acquisition of the lock

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'multi_op_queue'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install multi_op_queue

## Usage

```ruby
require 'multi_op_queue'

queue = ::MutiOpQueue::Queue.new
queue.push(1)
queue.push(2)

items = queue.pop_up_to(2)
# [ 1, 2 ]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/multi_op_queue.

