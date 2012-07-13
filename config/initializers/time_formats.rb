# config/initializers/time_formats.rb
Date::DATE_FORMATS[:month_and_year] = "%B %Y"
Date::DATE_FORMATS[:short_ordinal] = lambda { |date| date.strftime("%B #{date.day.ordinalize}") }