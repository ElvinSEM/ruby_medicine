# frozen_string_literal: true

# # app/jobs/telegram_bot_job.rb
# class TelegramBotJob < ApplicationJob
#   queue_as :default
#
#   def perform
#     require 'telegram/bot'
#
#     Telegram::Bot::Client.run(ENV['TELEGRAM_BOT_API_TOKEN']) do |bot|
#       bot.listen do |message|
#         case message.text
#         when '/start'
#           bot.api.send_message(chat_id: message.chat.id, text: "Привет, я ваш бот. Добро пожаловать в офтальмологическую клинику!")
#         when '/help'
#           bot.api.send_message(chat_id: message.chat.id, text: "Команды:\n/start - Начало работы\n/about - О клинике\n/contact - Контакты")
#         when '/about'
#           bot.api.send_message(chat_id: message.chat.id, text: "Мы - современная офтальмологическая клиника, предлагающая полный спектр услуг по лечению глаз.")
#         when '/contact'
#           bot.api.send_message(chat_id: message.chat.id, text: "Контакты клиники:\nТелефон: +123456789\nАдрес: ул. Здоровья, д. 10")
#         else
#           bot.api.send_message(chat_id: message.chat.id, text: "Извините, я не понимаю эту команду. Попробуйте /help для получения списка команд.")
#         end
#       end
#     end
#   end
# end
#   require 'telegram/bot'
#
#   Telegram::Bot::Client.run(ENV['TELEGRAM_BOT_API_TOKEN']) do |bot|
#     bot.listen do |message|
#       case message
#       when Telegram::Bot::Types::Message
#         case message.text
#         when '/start'
#           bot.api.send_message(chat_id: message.chat.id, text: "Привет, я ваш бот. Добро пожаловать в офтальмологическую клинику!")
#         when '/help'
#           bot.api.send_message(chat_id: message.chat.id, text: "Команды:\n/start - Начало работы\n/about - О клинике\n/contact - Контакты")
#         when '/about'
#           bot.api.send_message(chat_id: message.chat.id, text: "Мы - современная офтальмологическая клиника, предлагающая полный спектр услуг по лечению глаз.")
#         when '/contact'
#           keyboard = [
#             [
#               Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Посетите наш сайт', url: 'https://yourwebsite.com')
#             ],
#             [
#               Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Позвонить', url: 'tel:+123456789')
#             ]
#           ]
#           markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: keyboard)
#           bot.api.send_message(chat_id: message.chat.id, text: "Контакты клиники:\nТелефон: +123456789\nАдрес: ул. Здоровья, д. 10", reply_markup: markup)
#         else
#           bot.api.send_message(chat_id: message.chat.id, text: "Извините, я не понимаю эту команду. Попробуйте /help для получения списка команд.")
#         end
#       when Telegram::Bot::Types::CallbackQuery
#         case message.data
#         when 'about'
#           bot.api.send_message(chat_id: message.message.chat.id, text: "Мы - современная офтальмологическая клиника, предлагающая полный спектр услуг по лечению глаз.")
#         when 'contact'
#           bot.api.send_message(chat_id: message.message.chat.id, text: "Контакты клиники:\nТелефон: +123456789\nАдрес: ул. Здоровья, д. 10\nВеб-сайт: https://yourwebsite.com")
#         when 'help'
#           bot.api.send_message(chat_id: message.message.chat.id, text: "Команды:\n/start - Начало работы\n/about - О клинике\n/contact - Контакты")
#         end
#       end
#     end
#   end
#
# end
#   #
# class TelegramBotJob < ApplicationJob
#   queue_as :default
#
#   def perform
#     require 'telegram/bot'
#   Telegram::Bot::Client.run(ENV['TELEGRAM_BOT_API_TOKEN']) do |bot|
#       bot.listen do |message|
#         case message.text
#         when '/start'
#           keyboard = [
#             [Telegram::Bot::Types::KeyboardButton.new(text: 'Записаться на прием')],
#             [Telegram::Bot::Types::KeyboardButton.new(text: 'О клинике')],
#             [Telegram::Bot::Types::KeyboardButton.new(text: 'Контакты')]
#           ]
#           reply_markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(
#             keyboard: keyboard,
#             resize_keyboard: true,
#             one_time_keyboard: true
#           )
#           bot.api.send_message(chat_id: message.chat.id, text: "Добро пожаловать в офтальмологическую клинику!", reply_markup: reply_markup)
#         when 'Записаться на прием'
#           bot.api.send_message(chat_id: message.chat.id, text: "Для записи на прием, пожалуйста, свяжитесь с нами по телефону +123456789.")
#         when 'О клинике'
#           bot.api.send_message(chat_id: message.chat.id, text: "Мы - современная офтальмологическая клиника, предлагающая полный спектр услуг по лечению глаз.")
#         when 'Контакты'
#           bot.api.send_message(chat_id: message.chat.id, text: "Контакты клиники:\nТелефон: +123456789\nАдрес: ул. Здоровья, д. 10")
#         else
#           bot.api.send_message(chat_id: message.chat.id, text: "Извините, я не понимаю эту команду. Попробуйте снова.")
#         end
#       end
#     end
#   end
# end
# require 'telegram/bot'
#
# class TelegramBotJob < ApplicationJob
#   queue_as :default
#
#   def perform
#     Telegram::Bot::Client.run(ENV['TELEGRAM_BOT_API_TOKEN']) do |bot|
#       bot.listen do |message|
#         case message.text
#         when '/start'
#           keyboard = [
#             [Telegram::Bot::Types::KeyboardButton.new(text: 'Записаться на прием')],
#             [Telegram::Bot::Types::KeyboardButton.new(text: 'О клинике')],
#             [Telegram::Bot::Types::KeyboardButton.new(text: 'Контакты')]
#           ]
#           reply_markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(
#             keyboard: keyboard,
#             resize_keyboard: true,
#             one_time_keyboard: true
#           )
#           bot.api.send_message(chat_id: message.chat.id, text: "Добро пожаловать в офтальмологическую клинику!", reply_markup: reply_markup)
#
#         when 'Записаться на прием'
#           bot.api.send_message(chat_id: message.chat.id, text: "Пожалуйста, выберите удобное время для приема:")
#           available_slots = generate_available_slots
#           bot.api.send_message(chat_id: message.chat.id, text: "Доступные временные слоты:", reply_markup: available_slots)
#
#         when /Выбрать время: (.+)/
#           chosen_time = message.text.match(/Выбрать время: (.+)/)[1]
#           appointment_time = Time.parse(chosen_time)
#           user = User.find_or_create_by(username: message.from.first_name, chat_id: message.chat.id)
#           doctor = Doctor.first # Выберите доктора для простоты
#
#           if Appointment.exists?(doctor_id: doctor.id, start_time: appointment_time)
#             bot.api.send_message(chat_id: message.chat.id, text: "Это время уже занято. Пожалуйста, выберите другое время.")
#             available_slots = generate_available_slots
#             bot.api.send_message(chat_id: message.chat.id, text: "Доступные временные слоты:", reply_markup: available_slots)
#           else
#             appointment = Appointment.create(user: user, doctor: doctor, start_time: appointment_time)
#             if appointment.persisted?
#               confirmation_message = "Вы успешно записаны на прием к #{doctor.name} на #{appointment.start_time.strftime('%Y-%m-%d %H:%M')}."
#               bot.api.send_message(chat_id: message.chat.id, text: confirmation_message)
#             else
#               bot.api.send_message(chat_id: message.chat.id, text: "Ошибка при записи на прием. Попробуйте снова.")
#             end
#           end
#
#         when 'О клинике'
#           bot.api.send_message(chat_id: message.chat.id, text: "Мы - современная офтальмологическая клиника, предлагающая полный спектр услуг по лечению глаз.")
#
#         when 'Контакты'
#           bot.api.send_message(chat_id: message.chat.id, text: "Контакты клиники:\nТелефон: +123456789\nАдрес: ул. Здоровья, д. 10")
#
#         else
#           bot.api.send_message(chat_id: message.chat.id, text: "Извините, я не понимаю эту команду. Попробуйте снова.")
#         end
#       end
#     end
#   end
#
#   private
#
#   def generate_available_slots
#     slots = []
#     current_time = Time.now.change(hour: 9, min: 0)
#     end_time = Time.now.change(hour: 18, min: 0)
#
#     while current_time <= end_time
#       slots << current_time.strftime('%Y-%m-%d %H:%M')
#       current_time += 30.minutes
#     end
#
#     occupied_slots = Appointment.where(start_time: Time.now.beginning_of_day..Time.now.end_of_day).pluck(:start_time)
#     available_slots = slots - occupied_slots.map { |t| t.strftime('%Y-%m-%d %H:%M') }
#
#     keyboard_buttons = available_slots.map do |slot|
#       Telegram::Bot::Types::InlineKeyboardButton.new(text: slot, callback_data: "Выбрать время: #{slot}")
#     end
#
#     Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: keyboard_buttons.each_slice(3).to_a)
#   end
# end
#
# class TelegramBotJob < ApplicationJob
#   queue_as :default
#
#   def perform
#     Telegram::Bot::Client.run(ENV['TELEGRAM_BOT_API_TOKEN']) do |bot|
#       bot.listen do |message|
#         Rails.logger.debug "Received message: #{message.inspect}"
#
#         case message.text
#         when '/start'
#           send_welcome_message(bot, message.chat.id)
#         when 'Записаться на прием'
#           send_available_slots(bot, message.chat.id)
#         when /Выбрать время: (.+)/
#           process_time_selection(bot, message)
#         when 'О клинике'
#           send_clinic_info(bot, message.chat.id)
#         when 'Контакты'
#           send_contacts(bot, message.chat.id)
#         else
#           bot.api.send_message(chat_id: message.chat.id, text: "Извините, я не понимаю эту команду. Попробуйте снова.")
#         end
#       end
#     end
#   end
#
#   private
#
#   def send_welcome_message(bot, chat_id)
#     keyboard = [
#       [Telegram::Bot::Types::KeyboardButton.new(text: 'Записаться на прием')],
#       [Telegram::Bot::Types::KeyboardButton.new(text: 'О клинике')],
#       [Telegram::Bot::Types::KeyboardButton.new(text: 'Контакты')]
#     ]
#     reply_markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(
#       keyboard: keyboard,
#       resize_keyboard: true,
#       one_time_keyboard: true
#     )
#     bot.api.send_message(chat_id: chat_id, text: "Добро пожаловать в офтальмологическую клинику!", reply_markup: reply_markup)
#   end
#
#   def send_available_slots(bot, chat_id)
#     available_slots_markup = generate_available_slots
#     bot.api.send_message(chat_id: chat_id, text: "Пожалуйста, выберите удобное время для приема:", reply_markup: available_slots_markup)
#   end
#
#   def process_time_selection(bot, message)
#     chosen_time = message.text.match(/Выбрать время: (.+)/)[1]
#     Rails.logger.debug "Parsed time: #{chosen_time}"
#
#     begin
#       appointment_time = Time.parse(chosen_time)
#     rescue ArgumentError
#       bot.api.send_message(chat_id: message.chat.id, text: "Неверный формат времени. Попробуйте снова.")
#       return
#     end
#
#     AppointmentCreationJob.perform_later(message.from.first_name, message.chat.id, appointment_time)
#   end
#
#   def send_clinic_info(bot, chat_id)
#     bot.api.send_message(chat_id: chat_id, text: "Мы - современная офтальмологическая клиника, предлагающая полный спектр услуг по лечению глаз.")
#   end
#
#   def send_contacts(bot, chat_id)
#     bot.api.send_message(chat_id: chat_id, text: "Контакты клиники:\nТелефон: +123456789\nАдрес: ул. Здоровья, д. 10")
#   end
#
#   def generate_available_slots
#     slots = []
#     current_time = Time.now.change(hour: 9, min: 0)
#     end_time = Time.now.change(hour: 18, min: 0)
#
#     while current_time <= end_time
#       slots << current_time.strftime('%Y-%m-%d %H:%M')
#       current_time += 30.minutes
#     end
#
#     occupied_slots = Appointment.where(start_time: Time.now.beginning_of_day..Time.now.end_of_day).pluck(:start_time)
#     available_slots = slots - occupied_slots.map { |t| t.strftime('%Y-%m-%d %H:%M') }
#
#     keyboard_buttons = available_slots.map do |slot|
#       Telegram::Bot::Types::InlineKeyboardButton.new(text: slot, callback_data: "Выбрать время: #{slot}")
#     end
#
#     Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: keyboard_buttons.each_slice(3).to_a)
#   end
# end

class AppointmentCreationJob < ApplicationJob
  queue_as :default

  def perform(username, chat_id, appointment_time)
    user = User.find_or_create_by(username:, chat_id:)
    doctor = Doctor.first

    if Appointment.exists?(doctor_id: doctor.id, start_time: appointment_time)
      bot.api.send_message(chat_id:, text: 'Это время уже занято. Пожалуйста, выберите другое время.')
      send_available_slots(bot, chat_id)
    else
      appointment = Appointment.new(user:, doctor:, start_time: appointment_time)
      if appointment.save
        confirmation_message = "Вы успешно записаны на прием к #{doctor.name} на #{appointment.start_time.strftime('%Y-%m-%d %H:%M')}."
        bot.api.send_message(chat_id:, text: confirmation_message)
      else
        bot.api.send_message(chat_id:, text: 'Ошибка при записи на прием. Попробуйте снова.')
      end
    end
  end

  private

  def bot
    @bot ||= Telegram::Bot::Client.new(ENV['TELEGRAM_BOT_API_TOKEN'])
  end

  def send_available_slots(bot, chat_id)
    available_slots_markup = generate_available_slots
    bot.api.send_message(chat_id:, text: 'Пожалуйста, выберите удобное время для приема:',
                         reply_markup: available_slots_markup)
  end
end
