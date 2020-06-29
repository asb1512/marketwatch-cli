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

    # Defines parameters necessary to request data types. The data type requiring extra info in get request is intraday.
    def params_daily
        self.class.get("#{self.function}&#{self.symbol}&#{self.key}")
    end

    def params_daily_adjusted
        self.class.get("#{self.function}&#{self.symbol}&#{self.key}")
    end

    def params_intraday
        self.class.get("#{self.function}&#{self.symbol}&#{self.interval}&#{self.key}")
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

class Date < AlphaVantage
    def dayname
        DAYNAMES[self.wday]
    end

    def abbr_dayname
        ABBR_DAYNAMES[self.wday]
    end
    binding.pry
end

# Used for testing/development purposes.
# alpha_vantage = AlphaVantage.new
# puts alpha_vantage.params