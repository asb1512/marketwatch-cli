require 'rubygems'
require 'httparty'
require 'date'
require 'pry'

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

    attr_reader :key, :today, :yesterday, :desired_date 
    attr_accessor :function, :symbol, :interval, :key
    
    # Calls API base URL.
    include HTTParty
    base_uri "https://www.alphavantage.co/query?"

    def initialize
        @key = "apikey=W950UXLR0AH9JKAL"
        @today = Date.today.strftime
        @yesterday = Date.today.prev_day.strftime
    end

    # Defines parameters necessary to request data types.
    def params
        # self.class.get('function=TIME_SERIES_DAILY&symbol=DOCU&apikey=W950UXLR0AH9JKAL')
        self.class.get("#{@function}&#{@symbol}&#{self.key}")
    end

    # Sets the correct instance variable values for the correct API call formatting. 
    def intraday(symbol = "AAPL", interval = "5")
        @function = "function=TIME_SERIES_INTRADAY"
        @symbol = "symbol=#{symbol}"
        @interval = "interval=#{interval}min"
    end

    # Sets the correct instance variable values for the correct API call formatting.
    def daily(symbol = "AAPL")
        @function = "function=TIME_SERIES_DAILY"
        @symbol = "symbol=#{symbol}"
    end

    # Sets the correct instance variable values for the correct API call formatting.
    def daily_adjusted(symbol = "AAPL")
        @function = "function=TIME_SERIES_DAILY_ADJUSTED"
        @symbol = "symbol=#{symbol}"
    end

end


# Used for testing/development purposes.
# alpha_vantage = AlphaVantage.new
# puts alpha_vantage.params