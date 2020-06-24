class Display

    def display_daily
        puts "Please enter the symbol for the company you're looking for:"
        input = gets.strip.upcase
        alpha = AlphaVantage.new
        alpha.daily(input)

        # alpha.params.find {|i| "#{DATE_TODAY}"}

        # alpha.params.each do |e| 
        #         binding.pry
        # end

        puts alpha.params["Time Series (Daily)"][DATE_TODAY]

    end

end