require_relative "./date.rb"
require_relative "./company.rb"
require_relative "./display.rb"
require_relative "./cli.rb"

require 'rubygems'
require 'httparty'
require 'date'
require 'pry'
require 'json'
require 'colorize'

# ________________________________
# .env gem to hide API key, put in .gitignore file and use a .env variable to hide your API key
# ________________________________
# Responsible for making calls to API.
class AlphaVantage
# API Key: W950UXLR0AH9JKAL
# This will be specific to the user.
# API_KEY = "apikey=W950UXLR0AH9JKAL"

# This returns today's date as: YYYY-MM-DD
# DATE_TODAY = Time.now.to_s[/\d{4}-\d{2}-\d{2}/]
# DATE_TODAY = Time.now.strftime('%Y-%m-%d')
# DATE_TODAY = Date.today.strftime
# DATE_YESTERDAY = Date.today.prev_day.strftime

    attr_reader :key, :today, :yesterday, :desired_date, :date
    attr_accessor :function, :symbol, :symbol_format, :key, :get_request

    # Calls API base URL.
    include HTTParty
    base_uri "https://www.alphavantage.co/query?"

    def initialize
        @key = "apikey=W950UXLR0AH9JKAL"
        @today = Date.today.strftime
        @yesterday = Date.today.prev_day.strftime
        @date = Date.new
        @request = self.class.get("#{self.function}&#{self.symbol}&#{self.key}")
        # Sets the correct instance variable values for the correct API call formatting.
        @function = "function=TIME_SERIES_DAILY"
        @symbol_format = "symbol=#{symbol}"
        # binding.pry
    end

    def get_request
        self.class.get("#{self.function}&#{self.symbol}&#{self.key}")
    end
    
end