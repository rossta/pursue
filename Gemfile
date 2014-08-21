source "https://rubygems.org"

ruby "2.1.2"

gem "rails", "4.1.4"

gem "unicorn"

gem "pg"

gem "redis"
gem "dalli"

gem "bourbon", "~> 3.2.1"
gem "neat", "~> 1.5.1"
gem "coffee-rails"
gem "jquery-rails"
gem "sass-rails", "~> 4.0.3"
gem "uglifier"
gem "bower-rails"

gem "email_validator"
gem "recipient_interceptor"

gem "title"
gem "flutie"
gem "high_voltage"
gem "i18n-tasks"
gem "simple_form"

gem "rack-timeout"
gem "rack-protection"

gem "devise"

group :development do
  gem "spring"
  gem "spring-commands-rspec"
  gem "better_errors"
end

group :development, :test do
  gem "awesome_print"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "pry-rails"
  gem "pry-byebug"
  gem "rspec-rails", "~> 3.0.0"
end

group :test do
  gem "poltergeist"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers", require: false
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem "newrelic_rpm", ">= 3.7.3"
end
