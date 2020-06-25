require_relative "./alpha_vantage.rb"
require_relative "./display.rb"

# CLI Controller
class CLI

    def call
        puts "Welcome to Market Watch!"
        list_display_options
        puts "\n"
        goodbye
        puts "\n"
    end

    # Formats call to Alpha Vantage API dependent on which function the user desires.
    def list_display_options
        puts "Please enter the corresponding number of your desired data type:"
        puts <<-DOC.gsub /^\s*/, ''
            1. Intraday
            2. Daily
            3. Daily Adjusted
        DOC
        puts "You may enter 'main to access the main menu and 'exit' at any time to exit the program."
        menu
    end

    def menu
        # input = nil
        # while input != "exit"
            input = gets.strip.downcase
            if input == "1" || input == "intraday"
                intraday
            elsif input == "2" || input == "daily"
                Display.new.display_daily
            elsif input == "3" || input == "daily adjusted" || input == "adjusted"
                daily_adjusted
            elsif input == "main"
                list_display_options
            elsif input == "exit"
            end
        # end
    end

    def goodbye
        puts "Thanks for using Market Watch. See you tomorrow!"
    end

end