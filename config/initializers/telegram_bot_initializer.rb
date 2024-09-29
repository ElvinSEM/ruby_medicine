require 'sidekiq'
require 'telegram_bot_worker' # Убедитесь, что этот файл существует

if Rails.env.production? || Rails.env.development?
  TelegramBotWorker.perform_async
end
