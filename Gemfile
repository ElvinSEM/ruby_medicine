# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'
gem 'rails', '7.0.8.4'

gem 'active_link_to'
gem 'bcrypt'
gem 'bootsnap', require: false
gem 'breadcrumbs_on_rails'
gem 'cssbundling-rails'
gem 'devise'
gem 'dotenv-rails', groups: %i[development test]
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'pagy'
gem 'pg'
gem 'puma'
gem 'pundit'
gem 'rails-i18n'
gem 'redis'
gem 'sassc-rails'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'whenever', require: false

gem 'telegram-bot-ruby', '~> 1.0'

group :development, :test do
  gem 'exception-track', '~> 1.3'
  gem 'omniauth-test'

  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'faker', git: 'https://github.com/faker-ruby/faker.git'
  gem 'letter_opener'
  gem 'pry'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rubocop'
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'shoulda-matchers'
end
