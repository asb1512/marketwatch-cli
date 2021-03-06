require_relative "./alpha_vantage.rb"


# CLI Controller
class CLI

    attr_accessor :symbol_input, :formatted_date_input, :api_call


    def welcome
        puts "\n"
        puts "Welcome to Market Watch!"
        puts "----------------------------------------------"
        puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$".colorize(:green)
        puts "\n"
        symbol_choice
        puts "\n"
        date_choice
        puts "\n"
        more_data
        puts "\n"
    end



    # Prompts user for input on their desired equity and stores symbol.
    # Passes symbol input to API class for formatting in API call.
    def symbol_choice
        puts "Please enter the symbol of the equity that you are interested in:"
        @symbol_input = gets.strip.upcase

        puts "\n"
        puts "You may enter 'main' to access the main menu and 'exit' at any time to exit the program.".colorize(:yellow)
        puts "\n"

        if @symbol_input == "EXIT"
            goodbye
            exit
        else
            @api_call = AlphaVantage.new
            self.api_call.symbol = @symbol_input
            self.api_call.symbol_formatting
            self.api_call.get_request
        end
    end



    def date_choice

        puts "\n"
        puts "Data for today is not available until market close at 4:00PM EST.".colorize(:red)
        puts "\n"
        # Prompts user for time frame of the data.
        if self.api_call.date.day_today != "Saturday" && self.api_call.date.day_today != "Sunday" && self.api_call.date.day_today != "Monday"
            puts "Would you like to see data from today, yesterday, or another trading day?"
            puts "Make sure it's a trading day!".colorize(:red)
            puts "Enter 'today', 'yesterday', or enter a date in this format 'YYYY-MM-DD':"
            date_input = gets.strip.downcase
        elsif self.api_call.date.day_today == "Monday"
            puts "Would you like to see data from today or another trading day?"
            puts "Make sure it's a trading day!".colorize(:red)
            puts "Enter 'today' or enter a date in this format 'YYYY-MM-DD':"
            date_input = gets.strip.downcase
        elsif self.api_call.date.day_today == "Saturday"
            puts "Today isn't a trading day!".colorize(:red)
            puts "Enter 'yesterday' or enter a date in this format 'YYYY-MM-DD':"
            date_input = gets.strip.downcase
        elsif self.api_call.date.day_today == "Saturday"
            puts "Today isn't a trading day!".colorize(:red)
            puts "Enter a date in this format 'YYYY-MM-DD':"
            date_input = gets.strip.downcase
        end
        
        if date_input == "today"
            puts "\n"
            
            # If data for the current is not yet available, prompts user if they would like to see yesterday's numbers.
                # This needs to be changed to check if self.api_call.get_request hash contains requested date.
            if self.api_call.get_request["Time Series (Daily)"][self.api_call.today] == nil
                puts "Data for today is not yet available.".colorize(:red)
                puts "\n"
                puts "Would you like to see yesterday's numbers? Enter 'yes' or 'no':"
                y_n_input = gets.strip.downcase
                # If user selects 'no' then user is presented with symbol input menu.
                if y_n_input == "no"
                    date_choice
                # If user selects 'yes' then data for the selected symbol is shown from yesterday.
                elsif y_n_input == "yes"
                    puts "\n"
                        # puts self.alpha.params["Time Series (Daily)"][AlphaVantage::DATE_YESTERDAY]
                    @formatted_date_input = self.api_call.yesterday
                    self.api_call.date_desired = @formatted_date_input
                    date_choice
                end

            elsif
                # Converts 'today' into a date formatted as such, 'YYYY-MM-DD'.
                @formatted_date_input = self.api_call.today
                self.api_call.date_desired = @formatted_date_input
            end

        elsif date_input == "yesterday"
            puts "\n"
                # puts self.alpha.params["Time Series (Daily)"][AlphaVantage::DATE_YESTERDAY]
            # Converts 'yesterday' into a date formatted as such, 'YYYY-MM-DD'.
            @formatted_date_input = self.api_call.yesterday
            self.api_call.date_desired = @formatted_date_input

        elsif date_input.match?(/\d{4}-\d{2}-\d{2}/)
            @formatted_date_input = date_input
            self.api_call.date_desired = @formatted_date_input

        elsif date_input == "main"
            welcome

        elsif date_input == "" || date_input == " "
            puts "Invalid Date. Please start over."
            date_choice

        elsif date_input == "exit"
            puts "\n"
            goodbye
            exit
        
        else
            puts "\n"
            date_choice
        end

        self.api_call.assign_data
        display_data

    end


    def more_data
        # Once desired data is displayed, user is prompted if they would like to see a different day's data or choose a new symbol.
        puts "Would you like to see data for #{self.api_call.company.symbol} from a different day?".colorize(:light_blue)
        puts "Enter 'yes' or 'no':".colorize(:red)
        y_n_input = gets.strip.downcase

        if y_n_input == "y" || y_n_input == "yes"
            
            date_choice

        elsif y_n_input == "n" || y_n_input == "no" || y_n_input == "main"
            symbol_choice
        
        elsif y_n_input == "exit"
            puts "\n"
            goodbye

        else
            puts "Invalid input.".colorize(:red)
            more_data
        end

    end


    def goodbye

        puts "Thanks for using Market Watch. " + "See you tomorrow!".colorize(:blue)
    
    end


    def display_data

        puts "| SYMBOL: = #{self.api_call.company.symbol}".colorize(:light_blue)
        puts "|   OPEN: $#{self.api_call.company.open}".colorize(:green)
        puts "|   HIGH: $#{self.api_call.company.high}".colorize(:green)
        puts "|    LOW: $#{self.api_call.company.low}".colorize(:green)
        puts "|  CLOSE: $#{self.api_call.company.close}".colorize(:green)
        puts "| VOLUME: $#{self.api_call.company.volume}".colorize(:green)
    
    end

end