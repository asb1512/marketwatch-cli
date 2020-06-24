require_relative "./alpha_vantage.rb"
require_relative "./display.rb"

# CLI Controller
class CLI

    def call
        puts "Welcome to Market Watch!"
        list_display_options
        goodbye
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
            if input == "1"
                intraday
            elsif input == "2"
                Display.new.display_daily
            elsif input == "3"
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