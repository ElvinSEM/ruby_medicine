
class AppointmentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :index]
  before_action :set_problems, only: [:show, :edit, :update, :destroy]

  # before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  # before_action :time_slot_available, only: [:new, :create]
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
      if @appointment.save
        redirect_to @appointment, notice: 'Запись на прием успешно создана.'
      else
        msg = 'Выбранное время уже занято'
        #@doctors = Doctor.all
        #flash[:alert] = msg
        #render :new

        render turbo_stream: turbo_stream.append(:notices, partial: 'notices/notice', locals: { notices: msg, key: 'danger' })
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

      def user_params
        params.require(:appointment).permit(:email, :username, :password, :password_confirmation)
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

end