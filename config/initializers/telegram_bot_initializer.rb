# config/initializers/telegram_bot.rb
require_relative '../../app/workers/telegram_bot_worker'

Rails.application.config.after_initialize do
  user = User.first
  if user
    message = "Hello, #{user.username}! This is your Telegram message."
    TelegramBotWorker.perform_async # Вызов без аргументов
  else
    Rails.logger.warn 'No users found to send Telegram message.'
  end
end
