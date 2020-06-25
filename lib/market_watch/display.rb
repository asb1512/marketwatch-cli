# Allows to acces to class constants for dates.
require_relative "./alpha_vantage.rb"

class Display

    attr_accessor :alpha

    def initialize
        @alpha = AlphaVantage.new
    end

    # ALPHA = AlphaVantage.new

    # Handles the logic for daily data requests.
    # Returns 'open', 'high', 'low', 'close', and 'volume'.
    def display_daily
        puts "Please enter the symbol for the company you're looking for:"
        # Stores ticker symbol from user input.
        symbol_input = gets.strip.upcase
        # Instantiates new instance of AlphaVantage class.
        alpha = AlphaVantage.new
        # Sets the value of @symbol according to the ticker symbol input by the user.
        alpha.daily(symbol_input)

        # Prompts user for time frame of the data.
        puts "Would you like to see data from today, yesterday, or another day?"
        puts "Enter 'today', 'yesterday', or enter a date in this format 'YYYY-MM-DD':"
        date_input = gets.strip.downcase
        if date_input == "today"
            puts "\n"
            # If data for the current is not yet available, prompts user if they would like to see yesterday's numbers.
            if alpha.params["Time Series (Daily)"][DATE_TODAY] == nil
                puts "Data for today is not yet available."
                puts "\n"
                puts "Would you like to see yesterday's numbers? Enter 'yes' or 'no':"
                y_n_input = gets.strip.downcase
                if y_n_input == "no"
                    display_daily
                elsif y_n_input == "yes"
                    puts "\n"
                    puts alpha.params["Time Series (Daily)"][DATE_YESTERDAY] 
                end
            else
                puts alpha.params["Time Series (Daily)"][DATE_TODAY]
            end
        elsif date_input == "yesterday"
            puts "\n"
            puts alpha.params["Time Series (Daily)"][DATE_YESTERDAY]
            binding.pry
        elsif date_input == "main"
            list_display_options
        elsif date_input == "" || date_input == " "
            puts "Invalid Date. Please start over."
            display_daily
        elsif date_input == "exit"
        else
            puts "\n"
            puts alpha.params["Time Series (Daily)"][date_input]
        end
        
    end

    def display_data
        
    end

end