source "https://rubygems.org"

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"

#database
gem 'pg'

#envrioment
gem 'dotenv-rails'

#paginate
gem 'pagy', '~> 6.0'

#RabbitMQ
gem "bunny"
gem 'sneakers'

#Cron Jobs
gem 'whenever', require: false

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem "rack-cors"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ]
  gem "byebug"
  gem 'rspec-rails', '~> 6.1.0'
  gem 'factory_bot_rails'
  gem 'bunny-mock'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'shoulda-matchers', '~> 6.0'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

