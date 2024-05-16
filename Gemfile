source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"
gem "builder"
gem 'bcrypt', '~> 3.1.7'
gem 'devise', '~> 4.9.0'
gem 'dotenv-rails', '~> 2.8', '>= 2.8.1'
gem "importmap-rails"
gem 'faker', :git => 'https://github.com/faker-ruby/faker.git'
gem "mysql2", "~> 0.5"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.8"
gem "sprockets-rails"
gem "stimulus-rails"
gem 'sass-rails', '~> 6.0'
gem "turbo-rails"



group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot', '~> 6.4', '>= 6.4.6'
  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.3'
  gem 'pry'
  gem 'rspec-rails', '~> 6.1'
  gem 'rails-controller-testing'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem 'shoulda-matchers', '~> 4.0'

end
