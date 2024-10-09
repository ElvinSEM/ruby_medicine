require 'sidekiq'
require 'telegram_bot_worker' # Убедитесь, что этот файл существует
#
# if Rails.env.production? || Rails.env.development?
#   TelegramBotWorker.perform_async
# end

#
# # config/initializers/telegram_bot_initializer.rb
Thread.new do
  TelegramBotWorker.perform_async
end
