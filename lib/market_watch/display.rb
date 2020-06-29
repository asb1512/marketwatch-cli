# Allows to acces to class constants for dates.
require_relative "./alpha_vantage.rb"
require 'json'
require 'colorize'


class Display

    attr_accessor :intraday
    attr_reader :alpha, :daily, :daily_adjusted


    # Gives access to function type and desired symbol from user within the AlphaVantage class.
    def initialize
        @alpha = AlphaVantage.new
        @daily = "Time Series (Daily)"
        @daily_adjusted = "Time Series (Daily)"
        @intraday = nil
    end



    # Handles the logic for daily data requests.
    # Returns 'open', 'high', 'low', 'close', and 'volume'.
    def display_daily
        puts "Please enter the symbol for the company you're looking for:"
        # Stores ticker symbol from user input.
        symbol_input = gets.strip.upcase
        # Sets the value of @symbol according to the ticker symbol input by the user.
        self.alpha.daily(symbol_input)

        # Prompts user for time frame of the data.
        puts "Would you like to see data from today, yesterday, or another day?"
        puts "Enter 'today', 'yesterday', or enter a date in this format 'YYYY-MM-DD':"
        date_input = gets.strip.downcase
        if date_input == "today"
            puts "\n"
            # If data for the current is not yet available, prompts user if they would like to see yesterday's numbers.
            if self.alpha.params_daily["Time Series (Daily)"][self.alpha.today] == nil
                puts "Data for today is not yet available."
                puts "\n"
                puts "Would you like to see yesterday's numbers? Enter 'yes' or 'no':"
                y_n_input = gets.strip.downcase
                # If user selects 'no' then user is presented with symbol input menu.
                if y_n_input == "no"
                    display_daily
                # If user selects 'yes' then data for the selected symbol is shown from yesterday.
                elsif y_n_input == "yes"
                    puts "\n"
                    # puts self.alpha.params["Time Series (Daily)"][AlphaVantage::DATE_YESTERDAY]
                    daily_format(self.alpha.yesterday)
                end
            elsif 
                # puts self.alpha.params["Time Series (Daily)"][AlphaVantage::DATE_TODAY]
                daily_format(self.alpha.today)
            end
        elsif date_input == "yesterday"
            puts "\n"
            # puts self.alpha.params["Time Series (Daily)"][AlphaVantage::DATE_YESTERDAY]
            daily_format(self.alpha.yesterday)
        elsif date_input.match?(/\d{4}-\d{2}-\d{2}/)
            daily_format(date_input)
        elsif date_input == "main"
            list_display_options
        elsif date_input == "" || date_input == " "
            puts "Invalid Date. Please start over."
            display_daily(self.alpha.yesterday)
        elsif date_input == "exit"
        else
            puts "\n"
            puts self.alpha.params_daily["Time Series (Daily)"][date_input]
        end
        
    end


    # Handles the logic for intraday data requests.
    # Returns 'open', 'high', 'low', 'close', and 'volume' with respect to the given or default time interval.
    def display_intraday

        puts "Please enter the symbol for the equity you're looking for:"
        # Stores ticker symbol from user input.
        symbol_input = gets.strip.upcase

        puts "Please enter the number of the corresponding time interval desired."
        puts "1 min, 5 min, 15 min, 30 min, or 60 min:"
        interval_input = gets.strip
        @intraday = "Time Series (#{interval_input}min)"

        # Sets the value of @symbol according to the ticker symbol and time interval input by the user.
        self.alpha.intraday(symbol_input, interval_input)

        # Prompts user for time frame of the data.
        puts "Would you like to see data from today, yesterday, or another day?"
        puts "Enter 'today', 'yesterday', or enter a date in this format 'YYYY-MM-DD':"
        date_input = gets.strip.downcase

        if date_input == "today"
            puts "\n"
            # If data for the current is not yet available, prompts user if they would like to see yesterday's numbers.
            if self.alpha.params_intraday["Time Series (#{date_input}min)"][self.alpha.today] == nil
                puts "Data for today is not yet available."
                puts "\n"
                puts "Would you like to see yesterday's numbers? Enter 'yes' or 'no':"
                y_n_input = gets.strip.downcase

                # If user selects 'no' then user is presented with symbol input menu.
                if y_n_input == "no"
                    display_daily
                # If user selects 'yes' then data for the selected symbol is shown from yesterday.
                elsif y_n_input == "yes"
                    puts "\n"
                    # puts self.alpha.params["Time Series (Daily)"][AlphaVantage::DATE_YESTERDAY]
                    intraday_format(self.alpha.yesterday)
                end

            elsif 
                # puts self.alpha.params["Time Series (Daily)"][AlphaVantage::DATE_TODAY]
                intraday_format(self.alpha.today)
            end

        elsif date_input == "yesterday"
            puts "\n"
            # puts self.alpha.params["Time Series (Daily)"][AlphaVantage::DATE_YESTERDAY]
            intraday_format(self.alpha.yesterday)

        elsif date_input.match?(/\d{4}-\d{2}-\d{2}/)
            intraday_format(date_input)
        elsif date_input == "main"
            list_display_options
        elsif date_input == "" || date_input == " "
            puts "Invalid Date. Please start over."
            display_daily(self.alpha.yesterday)
        elsif date_input == "exit"
        else
            puts "\n"
            puts self.alpha.params_intraday["Time Series (Daily)"][date_input]
        end

    end


    def display_daily_adjusted
        puts "Please enter the symbol for the company you're looking for:"
        # Stores ticker symbol from user input.
        symbol_input = gets.strip.upcase
        # Sets the value of @symbol according to the ticker symbol input by the user.
        self.alpha.daily_adjusted(symbol_input)

        # Prompts user for time frame of the data.
        puts "Would you like to see data from today, yesterday, or another day?"
        puts "Enter 'today', 'yesterday', or enter a date in this format 'YYYY-MM-DD':"
        date_input = gets.strip.downcase
        if date_input == "today"
            puts "\n"
            # If data for the current is not yet available, prompts user if they would like to see yesterday's numbers.
            # This needs to be changed to reflected daily adjusted.s
            if self.alpha.params_daily_adjusted["Time Series (Daily)"][self.alpha.today] == nil
                puts "Data for today is not yet available."
                puts "\n"
                puts "Would you like to see yesterday's numbers? Enter 'yes' or 'no':"
                y_n_input = gets.strip.downcase
                # If user selects 'no' then user is presented with symbol input menu.
                if y_n_input == "no"
                    display_daily_adjusted
                # If user selects 'yes' then data for the selected symbol is shown from yesterday.
                elsif y_n_input == "yes"
                    puts "\n"
                    # puts self.alpha.params["Time Series (Daily)"][AlphaVantage::DATE_YESTERDAY]
                    daily_adjusted_format(self.alpha.yesterday)
                end
            elsif 
                # puts self.alpha.params["Time Series (Daily)"][AlphaVantage::DATE_TODAY]
                daily_adjusted_format(self.alpha.today)
            end
        elsif date_input == "yesterday"
            puts "\n"
            # puts self.alpha.params["Time Series (Daily)"][AlphaVantage::DATE_YESTERDAY]
            daily_adjusted_format(self.alpha.yesterday)
        elsif date_input.match?(/\d{4}-\d{2}-\d{2}/)
            daily_adjusted_format(date_input)
        elsif date_input == "main"
            list_display_options
        elsif date_input == "" || date_input == " "
            puts "Invalid Date. Please start over."
            display_daily_adjusted
        elsif date_input == "exit"
        else
            puts "\n"
            # This needs to be changed to reflected daily adjusted.
            puts self.alpha.params_daily_adjusted["Time Series (Daily)"][date_input]
        end
       
    end



    def daily_format(date)
        # Makes API call with correct function type and date based upon user input.
        # run = self.alpha.params[self.alpha.function][date]
        run = self.alpha.params_daily[self.daily][date]
        
        # puts <<-DOC
        #     |#{self.alpha.symbol.gsub('=', ' = ')}
        #     |   OPEN: $#{run["1. open"]}
        #     |   HIGH: $#{run["2. high"]}
        #     |    LOW: $#{run["3. low"]}
        #     |  CLOSE: $#{run["4. close"]}
        #     | VOLUME: $#{run["5. volume"]}
        # DOC

        # Cannot use a here doc and use colorize gem at the same time :(
        puts "|#{self.alpha.symbol.gsub('=', ' = ')}".colorize(:light_blue)
        puts "|   OPEN: $#{run["1. open"]}".colorize(:green)
        puts "|   HIGH: $#{run["2. high"]}".colorize(:green)
        puts "|    LOW: $#{run["3. low"]}".colorize(:green)
        puts "|  CLOSE: $#{run["4. close"]}".colorize(:green)
        puts "| VOLUME: $#{run["5. volume"]}".colorize(:green)

    end

    def intraday_format(date)
        # Makes API call with correct function type and date based upon user input.
        # run = self.alpha.params[self.alpha.function][date]
        # binding.pry
        run = self.alpha.params_intraday[self.intraday]

        # JSON.parse(strf_run)
        puts "––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––".colorize(:green)
        run.each do |key, value|
            puts "#{key} = #{value}".colorize(:light_blue)
        end

        # formatted = run.each do |key, value|
        #     p "#{key.rjust(run.keys.max_by(&:length).length)} #{value}"
        # end

        # puts <<-DOC
        #     |#{self.alpha.symbol.gsub('=', ' = ')}
        #     |   OPEN: $#{run["1. open"]}
        #     |   HIGH: $#{run["2. high"]}
        #     |    LOW: $#{run["3. low"]}
        #     |  CLOSE: $#{run["4. close"]}
        #     | VOLUME: $#{run["5. volume"]}
        # DOC
        
    end

    def daily_adjusted_format(date)
        # Makes API call with correct function type and date based upon user input.
        # run = self.alpha.params[self.alpha.function][date]
        run = self.alpha.params_daily_adjusted[self.daily_adjusted][date]
        
        puts <<-DOC
            |#{self.alpha.symbol.gsub('=', ' = ')}
            |              OPEN: $#{run["1. open"]}
            |              HIGH: $#{run["2. high"]}
            |               LOW: $#{run["3. low"]}
            |             CLOSE: $#{run["4. close"]}
            |    ADJUSTED CLOSE: $#{run["5. adjusted close"]}
            |            VOLUME: $#{run["6. volume"]}
            |   DIVIDEND AMOUNT: $#{run["7. dividend amount"]}
            | SPLIT COEFFICIENT: $#{run["8. split coefficient"]}
        DOC
        
    end

end