require_relative "./alpha_vantage.rb"
require_relative "./cli.rb"

class Company

    attr_accessor :symbol, :date, :open, :high, :low, :close, :volume, :adjusted_close, :dividend_amount, :split_coefficients

end