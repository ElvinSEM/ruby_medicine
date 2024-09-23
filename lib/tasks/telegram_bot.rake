# lib/tasks/telegram_bot.rake
namespace :telegram do
  desc 'Запустить Telegram бот'
  task start: :environment do
    TelegramBotWorker.perform_async
  end
end
