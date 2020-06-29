require 'pry'
require 'date'

class Date

    def dayname
        DAYNAMES[self.wday]
    end

    def abbr_dayname
        ABBR_DAYNAMES[self.wday]
    end

    today = Date.new
    
end