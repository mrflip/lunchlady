Date::DATE_FORMATS[:verbose] = lambda{|time| time.strftime("%A, %B #{time.day.ordinalize}") }
