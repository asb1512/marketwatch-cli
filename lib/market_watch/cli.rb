require_relative "./alpha_vantage.rb"
require_relative "./display.rb"

# CLI Controller
class CLI

    attr_accessor :symbol_input, :api_call

    def welcome
        puts "\n"
        puts "Welcome to Market Watch!"
        puts "----------------------------------------------"
        puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$".colorize(:green)
        puts "\n"
        symbol_choice
        puts "\n"
        goodbye
        puts "\n"
        binding.pry
    end

    # Prompts user for input on their desired equity and stores symbol.
    # Passes symbol input to API class for formatting in API call.
    def symbol_choice
        puts "Please enter the symbol of the equity that you are interested in:"
        @symbol_input = gets.strip.upcase
        @api_call = AlphaVantage.new
        api_call.symbol = @symbol_input
        puts "You may enter 'main' to access the main menu and 'exit' at any time to exit the program.".colorize(:red)
    end

    

    def goodbye
        puts "Thanks for using Market Watch. " + "See you tomorrow!".colorize(:blue)
    end

end