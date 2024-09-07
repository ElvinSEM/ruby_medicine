#
# class AppointmentsController < ApplicationController
#   before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :index]
#   before_action :set_problems, only: [:show, :edit, :update, :destroy]
#
#   # before_action :set_appointment, only: [:show, :edit, :update, :destroy]
#   # before_action :time_slot_available, only: [:new, :create]
#   def index
#     @appointments = current_user.appointments.includes(:doctor).all
#   end
#   def show
#     @appointment = Appointment.find(params[:id])
#   end
#
#   def new
#     @appointment = Appointment.new
#     @doctors = Doctor.all
#   end
#
#   def edit
#     @appointment = Appointment.find(params[:id])
#     @doctors = Doctor.all
#   end
#
#   def create
#       @appointment = current_user.appointments.build(appointment_params)
#       if @appointment.save
#         send_telegram_confirmation(@appointment)
#         schedule_appointment_reminder(@appointment)
#         redirect_to @appointment, notice: 'Запись на прием успешно создана.'
#       else
#         Rails.logger.debug(@appointment.errors.full_messages)
#
#         msg = 'Выбранное время уже занято'
#         #@doctors = Doctor.all
#         #flash[:alert] = msg
#         #render :new
#
#         render turbo_stream: turbo_stream.append(:notices, partial: 'notices/notice', locals: { notices: msg, key: 'danger' })
#       end
#   end
#
#   #
#   # def create
#   #   @appointment = current_user.appointments.build(appointment_params)
#   #   if @appointment.save
#   #     send_telegram_confirmation(@appointment)
#   #     schedule_appointment_reminder(@appointment)
#   #     redirect_to @appointment, notice: 'Запись на прием успешно создана.'
#   #   else
#   #     msg = 'Выбранное время уже занято'
#   #     render turbo_stream: turbo_stream.append(:notices, partial: 'notices/notice', locals: { notices: msg, key: 'danger' })
#   #   end
#   # end
#
#   def update
#     @appointment = Appointment.find(params[:id])
#     if @appointment.update(appointment_params)
#       redirect_to appointment_path, notice: 'Запись на прием успешно обновлена.'
#     else
#       render :edit
#     end
#   end
#
#   def destroy
#     @appointment = Appointment.find(params[:id])
#     @appointment.destroy!
#     redirect_to appointments_path
#   end
#
#
#   private
#
#   def appointment_params
#     params.require(:appointment).permit(:appointment_date, :status, :problem_description, :age, :doctor_id, :info, :problem_id, :start_time, :end_time)
#   end
#
#       def user_params
#         params.require(:appointment).permit(:email, :username, :password, :password_confirmation)
#       end
#
#   def set_problems
#     @problems = {
#       0 => "Проблема или заболевание",
#       1 => "Постоянно устают глаза",
#       2 => "Близорукость",
#       3 => "Дальнозоркость",
#       4 => "Глаукома",
#       5 => "Катаракта",
#       6 => "Конъюнктивит",
#       7 => "Другое"
#     }
#   end
#
#   private
#
#   # def send_telegram_confirmation(appointment)
#   #   bot = Telegram::Bot::Client.new(ENV['TELEGRAM_BOT_API_TOKEN'])
#   #   message = "Вы успешно записаны на прием к #{appointment.doctor.name} на #{appointment.start_time.strftime('%Y-%m-%d %H:%M')}."
#   #   bot.api.send_message(chat_id: appointment.user.chat_id, text: message)
#   # end
#   def send_telegram_confirmation(appointment)
#     if appointment.user.telegram_chat_id.present?
#       bot = ::Telegram::Bot::Client.new(ENV['TELEGRAM_BOT_API_TOKEN'])
#       message = "Ваша запись на прием подтверждена: #{appointment.details}"
#       bot.api.send_message(chat_id: appointment.user.telegram_chat_id, text: message)
#     else
#       Rails.logger.info "Пользователь #{appointment.user.id} не имеет telegram_chat_id, сообщение не отправлено."
#     end
#   end
#
#   def schedule_appointment_reminder(appointment)
#     reminder_time = appointment.start_time - 1.hour # Напоминание за 1 час до приема
#     ReminderJob.set(wait_until: reminder_time).perform_later(appointment.id)
#   end
#
#
# end
#


class AppointmentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :index]
  before_action :set_problems, only: [:show, :edit, :update, :destroy]

  def index
    @appointments = current_user.appointments.includes(:doctor).all
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def new
    @appointment = Appointment.new
    @doctors = Doctor.all
  end

  def edit
    @appointment = Appointment.find(params[:id])
    @doctors = Doctor.all
  end

  def create
    @appointment = current_user.appointments.build(appointment_params)
    # Проверка, что выбранное время кратно 30 минутам
    unless @appointment.start_time.min % 30 == 0
      @appointment.errors.add(:start_time, "Время записи должно быть кратным 30 минутам")
      render turbo_stream: turbo_stream.append(:notices, partial: 'notices/notice', locals: { notices: @appointment.errors.full_messages, key: 'danger' }) and return
    end
    if @appointment.save
      msg = "✅ *Запись подтверждена!*\n\n📅 *Дата:* #{@appointment.start_time.strftime('%d.%m.%Y')}\n🕒 *Время:* #{@appointment.start_time.strftime('%H:%M')}\n\nДо встречи!"
      # binding.pry
      # Передаем аргументы как именованные параметры
      TelegramService.call(user: current_user, message: msg)
      redirect_to @appointment, notice: 'Запись на прием успешно создана.'
    else
      render turbo_stream: turbo_stream.append(:notices, partial: 'notices/notice', locals: { notices: @appointment.errors.full_messages, key: 'danger' })
    end
  end


  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_params)
      redirect_to appointment_path, notice: 'Запись на прием успешно обновлена.'
    else
      render :edit
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy!
    redirect_to appointments_path
  end

  private

  def appointment_params
    params.require(:appointment).permit(:appointment_date, :status, :problem_description, :age, :doctor_id, :info, :problem_id, :start_time, :end_time)
  end

  def set_problems
    @problems = {
      0 => "Проблема или заболевание",
      1 => "Постоянно устают глаза",
      2 => "Близорукость",
      3 => "Дальнозоркость",
      4 => "Глаукома",
      5 => "Катаракта",
      6 => "Конъюнктивит",
      7 => "Другое"
    }
  end

  # def send_telegram_confirmation
  #   if @appointment.user.telegram_chat_id.present?
  #     bot = Telegram::Bot::Client.new(ENV['TELEGRAM_BOT_API_TOKEN'])
  #     doctor = appointment.doctor
  #     message = "Ваша запись на прием подтверждена: #{@appointment.start_time} - с доктором  #{doctor.name}"
  #     begin
  #       bot.api.send_message(chat_id: @appointment.user.telegram_chat_id, text: message)
  #     rescue Telegram::Bot::Exceptions::ResponseError => e
  #       Rails.logger.error "Ошибка Telegram API: #{e.message}"
  #     end
  #   else
  #     Rails.logger.info "Пользователь #{@appointment.user.id} не имеет telegram_chat_id, сообщение не отправлено."
  #   end
  # end
  #


  # def schedule_appointment_reminder
  #   # binding.pry
  #   reminder_time = appointment.start_time - 1.hour # Напоминание за 1 час до приема
  #   puts "Setting ReminderJob for appointment #{@appointment.id} at #{reminder_time}" # Debug output
  #
  #   ReminderJob.set(wait_until: reminder_time).perform_later(@appointment.id)
  #   puts "ReminderJob set" # Debug output
  #
  # end
end
