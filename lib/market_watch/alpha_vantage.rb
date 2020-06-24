require 'rubygems'
require 'httparty'
require 'date'
require 'pry'

# API Key: W950UXLR0AH9JKAL
# This will be specific to the user.
API_KEY = "apikey=W950UXLR0AH9JKAL"

# This returns today's date as: YYYY-MM-DD
DATE_TODAY = Time.now.to_s[/\d{4}-\d{2}-\d{2}/]

# Responsible for making calls to API.
class AlphaVantage

    attr_accessor :function, :symbol, :interval, :key
    # Calls API base URL.
    include HTTParty
    base_uri "https://www.alphavantage.co/query?"

    # Defines parameters necessary to request data types.
    def params
        # self.class.get('function=TIME_SERIES_DAILY&symbol=DOCU&apikey=W950UXLR0AH9JKAL')
        self.class.get("#{@function}&#{@symbol}&#{API_KEY}")
    end

    # 
    def intraday(symbol = "AAPL", interval = "5")
        @function = "function=TIME_SERIES_INTRADAY"
        @symbol = "symbol=#{symbol}"
        @interval = "interval=#{interval}min"
    end

    def daily(symbol = "AAPL")
        @function = "function=TIME_SERIES_DAILY"
        @symbol = "symbol=#{symbol}"
    end

    def daily_adjusted

    end

end


# Used for testing/development purposes.
# alpha_vantage = AlphaVantage.new
# puts alpha_vantage.params