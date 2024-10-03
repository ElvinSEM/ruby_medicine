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
