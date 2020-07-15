require 'bundler'

# Bundler.require

# require_all '../lib'

require_relative "./market_watch/version"
require_relative "./market_watch/cli"
require_relative "./market_watch/display"
require_relative "./market_watch/alpha_vantage"
require_relative "./market_watch/date"

require 'rubygems'
require 'httparty'
require 'date'
require 'pry'

# module Marketwatch
#   module Cli
#     class Error < StandardError; end
#     # Your code goes here...
#   end
# end