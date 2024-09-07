require 'devise'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

RSpec.configure do |config|
  config.before(:suite) do
    ActiveJob::Base.queue_adapter = :test
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.include FactoryBot::Syntax::Methods
    config.use_transactional_fixtures = true
  end

  # Настройка OmniAuth перед каждым тестом
  config.before(:each) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
                                                                         provider: 'google_oauth2',
                                                                         uid: '1234567890',
                                                                         info: {
                                                                           email: 'user@example.com',
                                                                           username: 'John Doe',
                                                                         },
                                                                         credentials: {
                                                                           token: 'abcdef123456',
                                                                           refresh_token: '12345abcdef',
                                                                           expires_at: Time.now + 1.week
                                                                         }
                                                                       })
  end

  # Включение Devise тестовых хелперов для контроллеров
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :feature

  # Инференция типа тестов на основе расположения файлов
  config.infer_spec_type_from_file_location!

  # Фильтрация бэкрейсов Rails из вывода ошибок
  config.filter_rails_from_backtrace!
end
