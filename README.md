# :jp: DomainValidator::Jp

<a href="https://rubygems.org/gems/domain_validator-jp" title="npm"><img src="https://img.shields.io/gem/v/domain_validator-jp.svg"></a>
<a href="https://travis-ci.org/kimromi/domain_validator-jp" title="travis"><img src="https://img.shields.io/travis/kimromi/domain_validator-jp.svg"></a>
<a href="https://github.com/kimromi/domain_validator-jp/blob/master/LICENSE" title="MIT License"><img src="https://img.shields.io/badge/license-MIT-blue.svg"></a>

domain name validator includes JP domain

## Usage

```rb
DomainValidator::Jp.new('example.jp').valid?        # => true
DomainValidator::Jp.new('日本語.jp').valid?         # => true

DomainValidator::Jp.new('①②③.jp').valid?            # => false
DomainValidator::Jp.new('example.wrongtld').valid?  # => false
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'domain_validator-jp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install domain_validator-jp

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kimromi/domain-validator-jp.
