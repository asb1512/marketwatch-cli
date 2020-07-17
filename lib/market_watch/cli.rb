require_relative "./alpha_vantage.rb"
require_relative "./display.rb"

# CLI Controller
class CLI

    attr_accessor :symbol_input

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
    end

    # Formats call to Alpha Vantage API dependent on which function the user desires.
    def symbol_choice
        puts "Please enter the symbol of the equity that you are interested in:"
        @symbol_input = gets.strip.upcase
        puts "You may enter 'main' to access the main menu and 'exit' at any time to exit the program.".colorize(:red)
        menu
    end

    

    def goodbye
        puts "Thanks for using Market Watch. " + "See you tomorrow!".colorize(:blue)
    end

end