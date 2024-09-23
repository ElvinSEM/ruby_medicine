# class AppointmentsController < ApplicationController
#   before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :index]
#   before_action :set_problems, only: [:show, :edit, :update, :destroy]
#
#   def index
#     @appointments = current_user.appointments.includes(:doctor).all
#   end
#
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
#     @appointment = current_user.appointments.build(appointment_params)
#     # Проверка, что выбранное время кратно 30 минутам
#     unless @appointment.start_time.min % 30 == 0
#       @appointment.errors.add(:start_time, "Время записи должно быть кратным 30 минутам")
#       render turbo_stream: turbo_stream.append(:notices, partial: 'notices/notice', locals: { notices: @appointment.errors.full_messages, key: 'danger' }) and return
#     end
#     if @appointment.save
#       msg = "✅ *Запись подтверждена!*\n\n📅 *Дата:* #{@appointment.start_time.strftime('%d.%m.%Y')}\n🕒 *Время:* #{@appointment.start_time.strftime('%H:%M')}\n\nДо встречи!"
#       # binding.pry
#       # Передаем аргументы как именованные параметры
#       TelegramService.call(user: current_user, message: msg)
#       redirect_to @appointment, notice: 'Запись на прием успешно создана.'
#     else
#       render turbo_stream: turbo_stream.append(:notices, partial: 'notices/notice', locals: { notices: @appointment.errors.full_messages, key: 'danger' })
#     end
#   end
#
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
#   private
#
#   def appointment_params
#     params.require(:appointment).permit(:appointment_date, :status, :problem_description, :age, :doctor_id, :info, :problem_id, :start_time, :end_time)
#   end
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
# end
#
# class AppointmentsController < ApplicationController
#   before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :index, :cancel]
#   before_action :set_appointment, only: [:show, :edit, :update, :destroy, :cancel]
#
#   def index
#     @appointments = current_user.appointments.includes(:doctor)
#   end
#
#   def show
#   end
#
#   def new
#     @appointment = Appointment.new
#     @doctors = Doctor.all
#   end
#
#   # def create
#   #   @appointment = current_user.appointments.build(appointment_params)
#   #
#   #   unless appointment_time_valid?
#   #     render_appointment_error('Время записи должно быть кратным 30 минутам') and return
#   #   end
#   #
#   #   if @appointment.save
#   #     send_telegram_confirmation(@appointment, '✅ Запись подтверждена!')
#   #     redirect_to @appointment, notice: 'Запись на прием успешно создана.'
#   #   else
#   #     render_appointment_error(@appointment.errors.full_messages)
#   #   end
#   # end
#
#   def create
#     @appointment = Appointment.new(appointment_params)
#     @appointment.user = current_user
#     @appointment.doctor = @doctor
#
#     if @doctor.available_on?(@appointment.appointment_date)
#       if @appointment.save
#         redirect_to @appointment, notice: 'Запись успешно создана.'
#       else
#         render :new, status: :unprocessable_entity
#       end
#     else
#       # Врач занят - уведомляем пользователя через телеграм и показываем сообщение
#       send_doctor_unavailable_notification(current_user, @doctor)
#       redirect_to doctors_path, alert: "К сожалению, все слоты у этого врача на эту дату заняты. Мы уведомим вас, как только он освободится."
#     end
#   end
#
#   def edit
#     @doctors = Doctor.all
#   end
#
#   def update
#     if @appointment.update(appointment_params)
#       redirect_to @appointment, notice: 'Запись на прием успешно обновлена.'
#     else
#       render :edit
#     end
#   end
#
#   def destroy
#     @appointment.destroy
#     redirect_to appointments_path, notice: 'Запись на прием была удалена.'
#   end
#
#   def cancel
#     # binding.pry  # Добавляем точку прерывания для отладки
#
#     if @appointment.update(status: 'cancelled')
#       send_telegram_confirmation(@appointment, '❌ Запись была отменена.')
#       redirect_to @appointment, notice: 'Запись успешно отменена.'
#     else
#       render_appointment_error('Не удалось отменить запись.')
#     end
#   end
#
#   private
#
#
#   def send_doctor_unavailable_notification(user, doctor)
#     # Логика отправки уведомления в телеграм
#     TelegramNotifier.send_message(user.telegram_id, "Доктор #{doctor.name} занят. Мы сообщим вам, как только он станет доступен.")
#
#     # Установим задачу для отправки уведомления за день до освобождения
#     if doctor.next_available_date
#       NotifyUserJob.set(wait_until: doctor.next_available_date - 1.day).perform_later(user, doctor)
#     end
#   end
#
#
#
#   def appointment_params
#     params.require(:appointment).permit(:appointment_date, :status, :problem_description, :age, :doctor_id, :start_time, :end_time)
#   end
#
#   def set_appointment
#     @appointment = current_user.appointments.find(params[:id])
#   end
#
#   def appointment_time_valid?
#     @appointment.start_time.min % 30 == 0
#   end
#
#   def render_appointment_error(message)
#     render turbo_stream: turbo_stream.append(:notices, partial: 'notices/notice', locals: { notices: message, key: 'danger' })
#   end
#
#   def send_telegram_confirmation(appointment, message_prefix)
#     message = "#{message_prefix}\n\n📅 Дата: #{appointment.start_time.strftime('%d.%m.%Y')}\n🕒 Время: #{appointment.start_time.strftime('%H:%M')}"
#     TelegramService.call(user: current_user, message: message)
#   end
# end



class AppointmentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :index, :cancel]
  before_action :set_appointment, only: [:show, :edit, :update, :destroy, :cancel]
  before_action :set_doctor, only: [:create]

  def index
    @appointments = current_user.appointments.includes(:doctor)
  end

  def show
  end

  def new
    @appointment = Appointment.new
    @doctors = Doctor.all
  end

  def create
    @appointment = current_user.appointments.build(appointment_params)
    @appointment.doctor = @doctor

    if @appointment.save
      send_telegram_confirmation(@appointment, '✅ Запись подтверждена!')
      redirect_to @appointment, notice: 'Запись успешно создана.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @doctors = Doctor.all
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to @appointment, notice: 'Запись успешно обновлена.'
    else
      render :edit
    end
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_path, notice: 'Запись на прием была удалена.'
  end

  def cancel
    if @appointment.update(status: 'cancelled')
      send_telegram_confirmation(@appointment, '❌ Запись была отменена.')
      redirect_to @appointment, notice: 'Запись успешно отменена.'
    else
      render_appointment_error('Не удалось отменить запись.')
    end
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:appointment][:doctor_id])
  end

  def appointment_params
    params.require(:appointment).permit(:appointment_date, :status, :problem_description, :age, :doctor_id, :start_time, :end_time)
  end

  def set_appointment
    @appointment = current_user.appointments.find(params[:id])
  end

  def send_telegram_confirmation(appointment, message_prefix)
    message = "#{message_prefix}\n\n📅 Дата: #{appointment.start_time.strftime('%d.%m.%Y')}\n🕒 Время: #{appointment.start_time.strftime('%H:%M')}"
    TelegramService.call(user: current_user, message: message)
  end
end
