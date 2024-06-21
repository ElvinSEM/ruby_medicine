source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"
gem "rails", "~> 7.0.8"

gem 'bcrypt'
gem "bootsnap", require: false
gem 'devise'
gem 'dotenv-rails'
gem "jsbundling-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "mysql2"
gem "puma"
gem "sprockets-rails"
gem "stimulus-rails"
gem 'sassc-rails'
#gem "turbo-rails"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git'
  gem 'pry'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem 'shoulda-matchers'
end
