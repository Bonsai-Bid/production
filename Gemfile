source "https://rubygems.org"

ruby "3.3.2"

gem 'rails', '>= 7.1.3'
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "redis"
gem "rexml", ">= 3.2.7"
gem "actiontext", ">= 7.1.3.3"
gem "nokogiri", ">= 1.16.5"
gem "redis-rails"
gem "sidekiq"
gem "sidekiq-cron", '~> 1.0'
gem "bcrypt", "~> 3.1.7"
gem "devise"
gem 'rubyzip', '~> 2.3.0'
gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false
gem 'jsonapi-serializer'
gem 'faraday'
gem 'phony_rails'
gem 'figaro'
# gem 'bootstrap', '~> 5.0'
gem 'selenium-webdriver'
gem 'skylight'
gem 'importmap-rails'
gem "vite_rails", "~> 3.0"
gem 'sprockets-rails'

group :development, :test do
  gem "debug", platforms: %i[mri windows]
  gem 'pry'
  gem 'capybara'
  gem 'launchy'
  gem 'bullet'
  gem 'awesome_nested_set'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'brakeman', require: false
  gem 'faker'
  gem 'bundler-audit', require: false
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem 'webmock'
  gem 'vcr'
  gem 'simplecov'
  gem 'shoulda-matchers', '~> 6.0'
  gem 'rails-controller-testing'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'webdrivers'
end
