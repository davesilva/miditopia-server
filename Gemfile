source 'https://rubygems.org'

# Rails
gem 'rails', '4.2.0.beta2'
gem 'rails-api'

# Postgres Database
gem 'pg'

# Unicorn app server
gem 'unicorn'

# API versioning
gem 'versionist'

# Testing
group :test, :development do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

group :development do
  gem 'spring'

  gem 'pry-rails'

  gem 'guard'
  gem 'rb-inotify', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-fchange', require: false
  gem 'libnotify', require: false
  gem 'growl', require: false
  gem 'terminal-notifier-guard', require: false

  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-bundler'
end
