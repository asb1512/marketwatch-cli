require_relative "./date.rb"
require_relative "./company.rb"
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

    attr_reader :key, :today, :yesterday, :date
    attr_accessor :symbol, :symbol_format, :date_desired, :key, :get_request, :response, :company


    # Calls API base URL.
    include HTTParty
    base_uri "https://www.alphavantage.co/query?"


    def initialize
        @key = "apikey=W950UXLR0AH9JKAL"
        @today = Date.today.strftime
        @yesterday = Date.today.prev_day.strftime
        @date = Date.new
        @company = Company.new
    end
    

    # Sets the correct instance variable values for the correct API call formatting.
    def symbol_formatting
        @symbol_format = "symbol=#{@symbol}"
    end


    # Formats get request to reflect user selected ticker symbol.
    def get_request
        self.class.get("function=TIME_SERIES_DAILY&#{self.symbol_format}&#{self.key}")
    end


    # Stores JSON hash returned by API, allowing for quicker data retrieval.
    def response
        @response ||= get_request
    end


    # Sets instance variabes in Company class and formats data to be displayed.
    def assign_data
        self.company.symbol = @symbol
        self.company.date = @date_desired

        self.company.open = response["Time Series (Daily)"][@date_desired]["1. open"]
        self.company.high = response["Time Series (Daily)"][@date_desired]["2. high"]
        self.company.low = response["Time Series (Daily)"][@date_desired]["3. low"]
        self.company.close = response["Time Series (Daily)"][@date_desired]["4. close"]
        self.company.volume = response["Time Series (Daily)"][@date_desired]["5. volume"]
    end
    
end