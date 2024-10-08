require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HospitalApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.time_zone = 'Moscow'
    config.active_record.default_timezone = :utc
    config.load_defaults 7.0
    config.i18n.available_locales = %i[en ru]
    config.i18n.default_locale = :ru
    config.i18n.fallbacks = [:en]
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.active_job.queue_adapter = :sidekiq
    # Настройки для сервера и клиента Sidekiq
    Sidekiq.configure_server do |config|
      config.redis = { url: ENV['REDIS_URL'] || 'redis://localhost:6379/0' }
    end

    Sidekiq.configure_client do |config|
      config.redis = { url: ENV['REDIS_URL'] || 'redis://localhost:6379/0' }
    end

    # config.after_initialize do
    #   user = User.first # Или любой другой способ получения пользователя
    #   if user
    #     message = "Hello, #{user.username}! This is your Telegram message."
    #     TelegramBotWorker.perform_async(user.id, message)
    #   else
    #     Rails.logger.warn "No users found to send Telegram message."
    #   end
    # end

  end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
end
