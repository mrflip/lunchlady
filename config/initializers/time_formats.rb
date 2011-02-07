Date::DATE_FORMATS[:verbose] = lambda{|time| time.strftime("%A, %b #{time.day.ordinalize}") }
