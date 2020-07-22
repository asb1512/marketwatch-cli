# Allows to acces to class constants for dates.
require_relative "./alpha_vantage.rb"
require_relative "./cli.rb"
require 'json'
require 'colorize'


class Display

    attr_reader :alpha, :daily, :company


    # Gives access to function type and desired symbol from user within the AlphaVantage class.
    def initialize
        @alpha = AlphaVantage.new
        @daily = "Time Series (Daily)"
        @company = Company.new()
    end


    # –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    # Handles the logic for daily data requests.
    # Returns 'open', 'high', 'low', 'close', and 'volume'.
    def display_daily

        # Prompts user for time frame of the data.
        if self.alpha.date.day_today != "Saturday" && self.alpha.date.day_today != "Sunday" && self.alpha.date.day_today != "Monday"
            puts "Would you like to see data from today, yesterday, or another trading day?"
            puts "Make sure it's a trading day!".colorize(:red)
            puts "Enter 'today', 'yesterday', or enter a date in this format 'YYYY-MM-DD':"
            date_input = gets.strip.downcase
        elsif self.alpha.date.day_today == "Monday"
            puts "Would you like to see data from today or another trading day?"
            puts "Make sure it's a trading day!".colorize(:red)
            puts "Enter 'today' or enter a date in this format 'YYYY-MM-DD':"
            date_input = gets.strip.downcase
        elsif self.alpha.date.day_today == "Saturday" || self.alpha.date.day_today == "Sunday"
            puts "Today isn't a trading day!".colorize(:red)
            puts "Please enter a valid trading day:"
            date_input = gets.strip.downcase
        end

        if date_input == "today"
            puts "\n"
            # If data for the current is not yet available, prompts user if they would like to see yesterday's numbers.
            if self.alpha.params_daily["Time Series (Daily)"][self.alpha.today] == nil
                puts "Data for today is not yet available.".colorize(:red)
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

    

    def daily_format(date)
        # Makes API call with correct function type and date based upon user input.
        # run = self.alpha.params[self.alpha.function][date]
        run = self.alpha.params_daily[self.daily][date]
        
        puts "|#{self.alpha.symbol.gsub('=', ' = ')}".colorize(:light_blue)
        puts "|   OPEN: $#{run["1. open"]}".colorize(:green)
        puts "|   HIGH: $#{run["2. high"]}".colorize(:green)
        puts "|    LOW: $#{run["3. low"]}".colorize(:green)
        puts "|  CLOSE: $#{run["4. close"]}".colorize(:green)
        puts "| VOLUME: $#{run["5. volume"]}".colorize(:green)

    end

end