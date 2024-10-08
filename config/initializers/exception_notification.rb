require 'exception_notification/sidekiq'

ExceptionNotification.configure do |config|
  config.add_notifier :email, {
    email_prefix: "[ERROR] ",
    sender_address: %{"notifier" <notifier@example.com>},
    exception_recipients: %w{exceptions@example.com}
  }
end
