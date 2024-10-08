# require 'exception_notification/sidekiq'
# Rails.application.config.middleware.use ExceptionNotification::Rack,
#                                         email: {
#                                           email_prefix: "[ERROR] ",
#                                           sender_address: %{"notifier" <notifier@example.com>},
#                                           exception_recipients: %w{admin@example.com}
#                                         }
#
