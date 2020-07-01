# Marketwatch::Cli
A simple CLI that leverages the Alpha Vantage API to deliver up-to-date stock info to the user.

This is a Ruby library to interface with the Alpha Vantage Public API, allowing the user to get stock info on the desired equity without leaving the command line.
This project is a submission for a Flatiron School ruby gem project.

This public API offers many more data types that could be added in the future. Feel free to fork and clone this repo and add more functionality!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'marketwatch-cli'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install marketwatch-cli

## Usage

(= Requirements =

This code has been run and tested on Ruby 2.6.1.

)

== External Deps ==

* HTTParty (https://github.com/jnunemaker/httparty) for making HTTP requests.
* colorize (https://github.com/fazibear/colorize) for coloring strings printed in the console.

== Standard Library Deps ==

* date (https://github.com/ruby/date) for handling the date of the requested data, as well as verifying whether the day in question is a trading/non-trading day.

== Alpha Vantage API ==

This public API allows for 5 requests/minute and a limit of 500 requests per day.
Feel to free to download your own API key to avoid reaching this limit here: (https://www.alphavantage.co/support/#api-key)

You will need to replace the current API key with your own.
Navigate to `marketwatch-cli/lib/market_watch/alpha_vantage.rb` and change the value of `@key` in `#initialize`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/asb1512/marketwatch-cli. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/asb1512/marketwatch-cli/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Marketwatch::Cli project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/asb1512/marketwatch-cli/blob/master/CODE_OF_CONDUCT.md).
