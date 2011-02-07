source 'http://rubygems.org'
gem 'rails', '3.0.3'
gem 'unicorn'
# Database
group :development, :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
end

# HTML and CSS replacement
gem 'haml', '~> 3.0'
gem 'haml-rails'
gem 'compass'
gem 'html5-boilerplate'
gem 'compass-960-plugin'

# Development
gem 'friendly_id', '~> 3.1'         # Human readable URLs
gem 'validates_existence', '~> 0.5' # Validation of associations

gem 'chronic'                       # Time parsing
gem 'will_paginate', '~> 3.0.pre2'  # Pagination of long lists
gem 'devise', '~> 1.1'            # User management
gem 'hpricot'                     # For Devise view generation
gem 'ruby_parser'                 # For Devise view generation

gem 'hassle',  :git => 'git://github.com/koppen/hassle.git'

# Testing
group :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rcov'
  gem 'forgery'
  gem 'steak'
  gem 'machinist'
  gem 'pickle'
  gem 'capybara'
  gem 'delorean'
  gem 'database_cleaner'
  gem 'spork'
end

group :development do
  gem 'nifty-generators'            # Much better scaffolding
  gem 'taps'                        # Teleportation of databases
  # platforms :ruby_19 do
  #   gem 'ruby-debug19'
  # end
  # platforms :ruby_18 do
  #   gem 'ruby-debug'
  # end
end

group :console do
  gem 'wirble'
  gem 'hirb'
  gem 'looksee'
  gem 'awesome_print'
end
