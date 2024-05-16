# class AppointmentsController < ApplicationController
#   class AppointmentsController < ApplicationController
#     def index
#       @appointments = Appointment.includes(:doctor, :patient).all
#     end
#   end
#   def new
#     @appointment = Appointment.new
#   end
#
#   def create
#     @appointment = Appointment.new(appointment_params)
#     if @appointment.save
#       # Обработка успешного сохранения записи
#       redirect_to root_path, notice: 'Запись на прием успешно создана.'
#     else
#       # Обработка ошибок валидации
#       render :new
#     end
#   end
#
#   private
#
#   def appointment_params
#     params.require(:appointment).permit(:appointment_date, :status, :doctor_id, :patient_id, :problem_description, :age)
#   end
# end
#
# class AppointmentsController < ApplicationController
#   before_action :authenticate_user!, only: [:new, :create]
#
#   def index
#     @appointments = Appointment.includes(:doctor, :patient).all
#   end
#
#   def new
#     @appointment = Appointment.new
#     @appointment.build_patient unless current_user.patient
#
#   end
#
#   def create
#     @appointment = Appointment.new(appointment_params)
#     @appointment.patient = current_user.patient || current_user.create_patient(patient_params)
#     @appointment.status = 'запланировано'
#     if @appointment.save
#       # Обработка успешного сохранения записи
#       redirect_to root_path, notice: 'Запись на прием успешно создана.'
#     else
#       # Обработка ошибок валидации
#       render :new
#     end
#   end
#
#   private
#
#   def appointment_params
#     params.require(:appointment).permit(:appointment_date, :status, :doctor_id,  :problem_description, :age)
#   end
#
#   def patient_params
#     params.require(:appointment).require(:patient).permit(:full_name, :phone, :email) # и другие поля пациента
#   end
# end


#
# class AppointmentsController < ApplicationController
#   before_action :authenticate_user!, only: [:new, :create]
#
#   def index
#     @appointments = Appointment.includes(:doctor, :patient).all
#   end
#
#   def new
#     @appointment = Appointment.new
#     @appointment.build_patient unless current_user.patient
#   end
#
#   def create
#     @appointment = current_user.appointments.build(appointment_params)
#     if @appointment.save
#       redirect_to appointments_path, notice: 'Запись на прием успешно создана.'
#     else
#       render :new
#     end
#   end
#
#   private
#
#   def appointment_params
#     params.require(:appointment).permit(:appointment_date, :status, :doctor_id, :problem_description, :age)
#   end
# end

#
# class AppointmentsController < ApplicationController
#
#     def index
#       @appointments = Appointment.includes(:doctor, :patient).all
#     end
#   def new
#     @appointment = Appointment.new
#   end
#
#   def create
#     user = User.new(user_params)
#     if user.save
#       patient = user.create_patient(patient_params)
#       appointment = patient.appointments.build(appointment_params)
#       if appointment.save
#         sign_in(user) # Devise helper to sign in the user
#         redirect_to root_path, notice: 'Registration successful and appointment booked.'
#       else
#         user.destroy # Optional: Remove user if appointment can't be created
#         render :new, alert: 'Appointment could not be booked.'
#       end
#     else
#       render :new, alert: 'User could not be registered.'
#     end
#   end
#
#   private
#
#   def user_params
#     params.permit(:username, :email, :password, :password_confirmation)
#   end
#
#   def patient_params
#     params.permit(:name, :phone)
#   end
#
#   def appointment_params
#     params.permit(:appointment_date, :doctor_id, :problem_description, :age)
#   end
# end

#
#
# class AppointmentsController < ApplicationController
#   before_action :build_new_user_and_appointment, only: [:new]
#   before_action :authenticate_user!, only: [:create], if: :user_signed_in?
#   protect_from_forgery with: :exception, except: :create # Добавляем исключение для экшена create
#
#   def index
#     @appointments = Appointment.includes(:doctor, :patient).all
#   end
#
#
#   def new
#     # @user и @appointment уже установлены в before_action
#   end
#
#   # def create
#   #   @user = User.new(user_params)
#   #   if @user.save
#   #     # Предполагаем, что метод create_patient создает профиль пациента и возвращает его
#   #     @patient = @user.create_patient(patient_params)
#   #
#   #     # Убедитесь, что у пациента есть ID перед созданием записи на прием
#   #     if @patient.persisted?
#   #       @appointment = @patient.appointments.build(appointment_params)
#   #       @appointment.patient_id = @patient.id
#   #
#   #       if @appointment.save
#   #         sign_in(@user) # Вход пользователя с помощью Devise
#   #         redirect_to root_path, notice: 'Registration successful and appointment booked.'
#   #       else
#   #         render :new
#   #       end
#   #     else
#   #       render :new
#   #     end
#   #   else
#   #     render :new
#   #   end
#   # end
#
#   def create
#     # Проверяем, существует ли пользователь с таким email
#     existing_user = User.find_by(email: user_params[:email])
#     if existing_user
#       flash.now[:alert] = 'Email уже зарегистрирован. Возможно, это ваш аккаунт? Попробуйте войти в систему или восстановить пароль, если вы его забыли.'
#       redirect_to new_user_session_path
#
#     else
#       @user = User.new(user_params)
#       if @user.save
#         # Предполагаем, что метод create_patient создает профиль пациента и возвращает его
#         @patient = @user.create_patient(patient_params)
#         # Убедитесь, что у пациента есть ID перед созданием записи на прием
#         if @patient.persisted?
#           @appointment = @patient.appointments.build(appointment_params)
#           if @appointment.save
#             sign_in(@user) # Вход пользователя с помощью Devise
#             redirect_to root_path, notice: 'Registration successful and appointment booked.'
#           else
#             set_error_notice(@appointment)
#
#             render :new
#           end
#         else
#           set_error_notice(@patient)
#           render :new
#         end
#       else
#         set_error_notice(@user)
#         render :new
#       end
#     end
#   end
#
#
#   private
#
#   def build_new_user_and_appointment
#     @user = User.new
#     @user.build_patient # Предполагаем, что у User есть метод build_patient
#     @appointment = Appointment.new
#   end
#
#   def set_error_notice(resource)
#     flash.now[:alert] = "There was a problem: #{resource.errors.full_messages.to_sentence}"
#   end
#   def patient_params
#     params.permit(:name, :phone)
#   end
#
#   def appointment_params
#     params.permit(:appointment_date, :problem_description, :age)
#   end
#   def user_params
#     params.permit(:username, :email, :password, :password_confirmation)
#   end
# end
# #


#
# class AppointmentsController < ApplicationController
#   before_action :authenticate_user!, only: [:new, :create]
#
#   def index
#     @appointments = Appointment.includes(:doctor, :patient).all
#   end
#
#   def new
#     @appointment = Appointment.new
#     @appointment.build_patient unless current_user.patient
#   end
#
#   def create
#     # Проверяем, существует ли пользователь с таким email
#     existing_user = User.find_by(email: user_params[:email])
#     if existing_user
#       @user = existing_user
#     else
#       @user = User.new(user_params)
#     end
#
#     if @user.save
#       # Предполагаем, что метод create_patient создает профиль пациента и возвращает его
#       @patient = @user.patient || @user.create_patient(patient_params)
#
#       @appointment = @patient.appointments.build(appointment_params)
#       if @appointment.save
#         sign_in(@user) # Вход пользователя с помощью Devise
#         redirect_to root_path, notice: 'Запись на прием успешно создана.'
#       else
#         set_error_notice(@appointment)
#         render :new
#       end
#     else
#       set_error_notice(@user)
#       render :new
#     end
#   end
#
#   private
#
#   def set_error_notice(resource)
#     flash.now[:alert] = "Произошла ошибка: #{resource.errors.full_messages.to_sentence}"
#   end
#
#   def patient_params
#     params.require(:patient).permit(:name, :phone)
#   end
#
#   def appointment_params
#     params.require(:appointment).permit(:appointment_date, :problem_id, :problem_description, :age, :doctor_id, :info)
#   end
#
#   def user_params
#     params.require(:user).permit(:username, :email, :password, :password_confirmation)
#   end
# end





class AppointmentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  def edit
    # @appointment устанавливается в before_action :set_appointment
  end

  def update
    # @appointment устанавливается в before_action :set_appointment
    if @appointment.update(appointment_params)
      redirect_to appointment_path(@appointment), notice: 'Запись на прием успешно обновлена.'
    else
      render :edit
    end
  end

  def destroy
    # @appointment устанавливается в before_action :set_appointment
    @appointment.destroy
    redirect_to appointments_path, notice: 'Запись на прием успешно удалена.'
  end



  def index
    @appointments = current_user.appointments.includes(:doctor).all
  end

  def new
    @appointment = Appointment.new
  end


  def show
    @appointment = Appointment.find(params[:id])
    # @appointment.problem_description = Appointment::PROBLEMS[@appointment.problem_id]

    # @appointment устанавливается в before_action :set_appointment
    # Здесь нет необходимости добавлять дополнительный код, так как @appointment уже установлен.
    # Если запись на прием не найдена, пользователь будет перенаправлен с сообщением об ошибке благодаря методу set_appointment.
  end


  def create
      @appointment = current_user.appointments.build(appointment_params)
      if @appointment.save
        redirect_to root_path, notice: 'Запись на прием успешно создана.'
      else
        render :new
      end
  end


  private

  def set_appointment
    @appointment = current_user.appointments.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to appointments_path, alert: 'Запись на прием не найдена.'
  end

  def appointment_params
    params.require(:appointment).permit(:appointment_date, :problem_description, :age, :doctor_id, :info, :problem_id)
  end

  def user_params
    params.require(:appointment).permit(:email, :username, :password, :password_confirmation)
  end

  # def patient_params
  #   params.require(:appointment).permit(patient_attributes: [:name, :phone])
  # end

end
