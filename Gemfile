source 'https://rubygems.org'
ruby '2.1.1'

# Rails
gem 'rails', '4.2.0.beta2'
gem 'rails-api'
gem 'responders', '~> 2.0'

# Postgres Database
gem 'pg'

# Unicorn app server
gem 'unicorn'

# CORS
gem 'rack-cors', require: 'rack/cors'

# API versioning
gem 'versionist'

# API response views
gem 'rabl'
gem 'oj'

# Secure passwords
gem 'bcrypt'

# Uploads
gem 'carrierwave'
gem 'fog'

# Testing
group :test, :development do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'shoulda-matchers', require: false
end

group :development do
  gem 'spring'

  gem 'pry-rails'
  gem 'pry-doc'

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

# For Heroku
gem 'rails_12factor', group: :production
