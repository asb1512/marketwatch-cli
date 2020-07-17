require_relative "./date.rb"

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
    attr_accessor :function, :symbol, :interval, :key, :get_request

    # Calls API base URL.
    include HTTParty
    base_uri "https://www.alphavantage.co/query?"

    def initialize
        @key = "apikey=W950UXLR0AH9JKAL"
        @today = Date.today.strftime
        @yesterday = Date.today.prev_day.strftime
        @date = Date.new
        @get_request = self.class.get("#{self.function}&#{self.symbol}&#{self.key}")
        
    end

    # Defines parameters necessary to request data types. The data type requiring extra info in get request is intraday.
    # def params_daily
    #     sleep 1
    #     @get_request = self.class.get("#{self.function}&#{self.symbol}&#{self.key}")
    #     binding.pry
    # end

#@output ||= self.class.get("#{self.function}&#{self.symbol}&#{self.key}") 
    # def params_daily_adjusted
    #     sleep 1
    #     self.class.get("#{self.function}&#{self.symbol}&#{self.key}")
    # end

    # def params_intraday
    #     sleep 1
    #     self.class.get("#{self.function}&#{self.symbol}&#{self.interval}&#{self.key}")
    # end

    # Sets the correct instance variable values for the correct API call formatting. 
    # def intraday(symbol = "AAPL", interval = "5")
    #     @function = "function=TIME_SERIES_INTRADAY"
    #     @symbol = "symbol=#{symbol}"
    #     @interval = "interval=#{interval}min"
    # end

    # Sets the correct instance variable values for the correct API call formatting.
    def daily(symbol = "AAPL")
        @function = "function=TIME_SERIES_DAILY"
        @symbol = "symbol=#{symbol}"
    end

    # Sets the correct instance variable values for the correct API call formatting.
    # def daily_adjusted(symbol = "AAPL")
    #     @function = "function=TIME_SERIES_DAILY_ADJUSTED"
    #     @symbol = "symbol=#{symbol}"
    # end
    
end

# Used for testing/development purposes.
# alpha_vantage = AlphaVantage.new
# puts alpha_vantage.params