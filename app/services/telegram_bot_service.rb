# # frozen_string_literal: true
#
# require 'telegram/bot'
# require 'net/http'
# require 'uri'
#
# class TelegramBotService
#   TOKEN = ENV['TELEGRAM_BOT_API_TOKEN']
#
#   def self.start
#     loop do
#       Telegram::Bot::Client.run(TOKEN) do |bot|
#         Rails.logger.info('Telegram бот успешно запущен!')
#
#         bot.listen do |message|
#           handle_message(bot, message)
#         end
#       end
#     rescue Telegram::Bot::Exceptions::ResponseError => e
#       Rails.logger.error("Ошибка соединения с Telegram API: #{e.message}")
#       sleep(5) # Задержка перед повторным запуском
#     rescue StandardError => e
#       Rails.logger.fatal("Критическая ошибка Telegram бота: #{e.message}")
#       sleep(5) # Задержка перед повторным запуском
#     end
#   end
#
#   def self.handle_message(bot, message)
#     case message.text
#     when '/start'
#       start_command(bot, message)
#     else
#       handle_phone_number(bot, message)
#     end
#   end
#
#   def self.start_command(bot, message)
#     telegram_chat_id = message.chat.id
#     bot.api.send_message(chat_id: telegram_chat_id,
#                          text: 'Добро пожаловать! Введите номер телефона, который вы использовали при регистрации на сайте.')
#   end
#
#   def self.handle_phone_number(bot, message)
#     telegram_chat_id = message.chat.id
#     phone_number = message.text.strip
#
#     # Валидация номера телефона (например, длина и формат)
#     unless valid_phone_number?(phone_number)
#       bot.api.send_message(chat_id: telegram_chat_id, text: 'Ошибка: неверный формат номера телефона.')
#       return
#     end
#
#     # Отправляем запрос на сервер Rails для сохранения telegram_chat_id
#     uri = URI.parse('http://localhost:3000/telegram/save_user_id')
#     request = Net::HTTP::Post.new(uri)
#     request.set_form_data('telegram_chat_id' => telegram_chat_id, 'phone' => phone_number)
#
#     begin
#       response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
#         http.request(request)
#       end
#
#       if response.is_a?(Net::HTTPSuccess)
#         bot.api.send_message(chat_id: telegram_chat_id, text: 'Ваш аккаунт успешно связан с Telegram!')
#       else
#         bot.api.send_message(chat_id: telegram_chat_id,
#                              text: 'Ошибка: не удалось связать Telegram с учетной записью. Проверьте введенный номер телефона.')
#       end
#     rescue StandardError => e
#       bot.api.send_message(chat_id: telegram_chat_id, text: "Произошла ошибка при запросе к серверу: #{e.message}")
#     end
#   end
#
#   def self.valid_phone_number?(phone_number)
#     # Пример простой валидации
#     phone_number.match?(/^\+?\d{10,15}$/) # Измените это условие на ваше требование
#   end
# end





# frozen_string_literal: true

require 'telegram/bot'
require 'net/http'
require 'uri'

class TelegramBotService
  TOKEN = ENV['TELEGRAM_BOT_API_TOKEN']

  @running = false # Флаг для отслеживания состояния бота

  def self.start
    return if @running # Проверяем, запущен ли уже бот

    @running = true # Устанавливаем флаг, что бот запущен

    loop do
      Telegram::Bot::Client.run(TOKEN) do |bot|
        Rails.logger.info('Telegram бот успешно запущен!')

        bot.listen do |message|
          handle_message(bot, message)
        end
      end
    rescue Telegram::Bot::Exceptions::ResponseError => e
      Rails.logger.error("Ошибка соединения с Telegram API: #{e.message}")
      sleep(5) # Задержка перед повторным запуском
    rescue StandardError => e
      Rails.logger.fatal("Критическая ошибка Telegram бота: #{e.message}")
      break # Выход из цикла при критической ошибке
    ensure
      @running = false # Сбрасываем флаг при завершении работы бота
    end
  end

  def self.handle_message(bot, message)
    case message.text
    when '/start'
      start_command(bot, message)
    else
      handle_phone_number(bot, message)
    end
  end

  def self.start_command(bot, message)
    telegram_chat_id = message.chat.id
    bot.api.send_message(chat_id: telegram_chat_id,
                         text: 'Добро пожаловать! Введите номер телефона, который вы использовали при регистрации на сайте.')
  end

  def self.handle_phone_number(bot, message)
    telegram_chat_id = message.chat.id
    phone_number = message.text.strip

    # Валидация номера телефона (например, длина и формат)
    unless valid_phone_number?(phone_number)
      bot.api.send_message(chat_id: telegram_chat_id, text: 'Ошибка: неверный формат номера телефона.')
      return
    end

    # Отправляем запрос на сервер Rails для сохранения telegram_chat_id
    uri = URI.parse('http://localhost:3000/telegram/save_user_id')
    request = Net::HTTP::Post.new(uri)
    request.set_form_data('telegram_chat_id' => telegram_chat_id, 'phone' => phone_number)

    begin
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.request(request)
      end

      if response.is_a?(Net::HTTPSuccess)
        bot.api.send_message(chat_id: telegram_chat_id, text: 'Ваш аккаунт успешно связан с Telegram!')
      else
        bot.api.send_message(chat_id: telegram_chat_id,
                             text: 'Ошибка: не удалось связать Telegram с учетной записью. Проверьте введенный номер телефона.')
      end
    rescue StandardError => e
      bot.api.send_message(chat_id: telegram_chat_id, text: "Произошла ошибка при запросе к серверу: #{e.message}")
    end
  end

  def self.valid_phone_number?(phone_number)
    # Пример простой валидации
    phone_number.match?(/^\+?\d{10,15}$/) # Измените это условие на ваше требование
  end
end
