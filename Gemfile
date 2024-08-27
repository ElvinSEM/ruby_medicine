source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"
gem "rails", "~> 7.0.8"

gem 'bcrypt'
gem "bootsnap", require: false
gem 'devise'
gem 'dotenv-rails',groups: [:development, :test]
gem "jsbundling-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem "mysql2"
gem "puma"
gem 'pundit'
gem 'rails-i18n'
gem "sprockets-rails"
gem "stimulus-rails"
gem 'sassc-rails'
gem "turbo-rails"
gem 'pagy'
gem 'active_link_to'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'redis'

gem 'telegram-bot-ruby', '~> 1.0'

group :development, :test do
  gem 'letter_opener'
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git'
  gem 'pry'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'rubocop'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem 'shoulda-matchers'
end
