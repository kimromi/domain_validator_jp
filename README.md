# DomainValidatorJp

domain name validator includes JP domain

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'domain-validator-jp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install domain-validator-jp

## Usage

```rb
DomainValidatorJp.valid?('example.jp')        # => true
DomainValidatorJp.valid?('日本語.jp')         # => true

DomainValidatorJp.valid?('①②③.jp')            # => false
DomainValidatorJp.valid?('example.wrongtld')  # => false
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kimromi/domain-validator-jp.
