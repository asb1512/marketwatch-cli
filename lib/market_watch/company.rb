require_relative ".alpha_vantage.rb"
require_relative ".display.rb"
require_relative ".cli.rb"

class Company

    attr_accesor :symbol, :date, :open, :high, :low, :close, :volume, :adjusted_close, :dividend_amount, :split_coefficient

    def initialize(symbol, date)
        @symbol = symbol
        @date = date
        @data = AlphaVantange.new.get_request
    end

    def 

end