require 'pry'
require 'date'

class Date

    attr_reader :day_today, :day_yesterday

    def initialize
        @day_today = Date.today.dayname
        @day_yesterday = Date.today.prev_day.dayname
    end

    def dayname
        DAYNAMES[self.wday]
    end

    def abbr_dayname
        ABBR_DAYNAMES[self.wday]
    end

end