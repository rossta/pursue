source 'https://rubygems.org'

ruby '2.1.5'

gem 'rails', '~> 4.2'

gem 'unicorn'

gem 'pg'

gem 'redis'
gem 'dalli'

gem 'foundation-rails'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'bower-rails'

gem 'email_validator'
gem 'recipient_interceptor'

gem 'title'
gem 'flutie'
gem 'high_voltage'
gem 'i18n-tasks'
gem 'simple_form'

gem 'rack-protection'

gem 'devise'
gem 'virtus'
gem 'ruby-units'

gem 'seed-fu'

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'annotate', '~> 2.6.5'
  gem 'quiet_assets'
end

group :development, :test do
  gem 'awesome_print'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 3.1.0'
end

group :test do
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'formulaic'
  gem 'launchy'
  gem 'shoulda-matchers', require: false
  gem 'timecop'
  gem 'webmock'
  gem 'guard-rspec'
end

group :staging, :production do
  gem 'newrelic_rpm', '>= 3.7.3'
end
