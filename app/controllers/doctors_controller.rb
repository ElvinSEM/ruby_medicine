class DoctorsController < ApplicationController
  before_action :set_doctor, only: %i[ show edit update destroy ]

  # GET /doctors
  def index
    @doctors = Doctor.all
  end

  # GET /doctors/1
  def show
    @doctor = Doctor.find(params[:id])
    respond_to do |format|
      format.html # _form.html.erb
      format.json { render json: @doctor }
    end
  end

  # GET /doctors/new
  def new
    @doctor = Doctor.new
  end

  # GET /doctors/1/edit
  def edit
  end

  # POST /doctors
  def create
    @doctor = Doctor.new(doctor_params)

    if @doctor.save
      redirect_to @doctor, notice: "Doctor was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /doctors/1
  def update
    if @doctor.update(doctor_params)
      redirect_to @doctor, notice: "Doctor was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /doctors/1
  def destroy
    @doctor.destroy
    redirect_to doctors_url, notice: "Doctor was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def doctor_params
      params.require(:doctor).permit(:name, :specialty, :phone)
    end
end




# class DoctorsController < ApplicationController
#   # before_action :set_doctor, only: %i[ show edit update destroy ]
#
#   # GET /doctors or /doctors.json
#   def index
#     @doctors = Doctor.all
#   end
#
#   # GET /doctors/1 or /doctors/1.json
#   def show
#     @doctor = Doctor.find(params[:id])
#     respond_to do |format|
#       format.html # _form.html.erb
#       format.json { render json: @doctor }
#     end
#   end
#
#   # GET /doctors/new
#   def new
#     @doctor = Doctor.new
#     # @schedule = @doctor.build_schedule # Создаем новое расписание для доктора
#
#   end
#
#   # GET /doctors/1/edit
#   def edit
#   end
#
#   # POST /doctors or /doctors.json
#   # schedule = Schedule.find_by(day: "пн-пт")
#   # @doctor = Doctor.new(doctor_params)
#   # @schedule = Schedule.find_by(params[:doctor][:schedule_id]) # Поиск расписания по переданному ID
#   # @doctor.schedule = @schedule
#   # schedule_attributes = doctor_params.delete(:schedule_attributes)
#
#   # @doctor.build_schedule(schedule_params)
#   def create
#     @doctor = Doctor.new(doctor_params)
#     # binding.pry
#     # binding.pry
#
#
#     # @schedule = Schedule.new(schedule_params) # Создание нового расписания
#     # @doctor.schedule = @schedule # Связывание расписания с доктором
#     # binding.pry
#     respond_to do |format|
#       if @doctor.save
#         format.html { redirect_to @doctor, notice: 'Доктор успешно создан.' }
#         format.json { render :show, status: :created, location: @doctor }
#       else
#         format.html { render :new, status: :unprocessable_entity }
#         format.json { render json: @doctor.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
#   # PATCH/PUT /doctors/1 or /doctors/1.json
#   def update
#     respond_to do |format|
#       if @doctor.update(doctor_params)
#         format.html { redirect_to doctor_url(@doctor), notice: "Doctor был успешно обновлен." }
#         format.json { render :show, status: :ok, location: @doctor }
#       else
#         format.html { render :edit, status: :unprocessable_entity }
#         format.json { render json: @doctor.errors, status: :unprocessable_entity }
#       end
#     end
#   end
#
#   # DELETE /doctors/1 or /doctors/1.json
#   def destroy
#     @doctor.destroy
#
#     respond_to do |format|
#       format.html { redirect_to doctors_url, notice: "Doctor был успешно удален." }
#       format.json { head :no_content }
#     end
#   end
#
#   private
#   # Use callbacks to share common setup or constraints between actions.
#   # def set_doctor
#   #   @doctor = Doctor.find(params[:id])
#   # end
#
#   # Only allow a list of trusted parameters through.
#   # def doctor_params
#   #   params.require(:doctor).permit(:name, :specialization, :salary, :schedule_id)
#   # end
#   def doctor_params
#     params.require(:doctor).permit(:name, :specialty, :patient_id, schedule_attributes: [:day, :start_time, :end_time])
#   end
#
#   # def schedule_params
#   #   params.require(:schedule).permit(:day, :start_time, :end_time)
#   # end
# end
