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
    @doctor = Doctor.find(params[:id])
    @doctor.destroy
    redirect_to doctors_url, notice: 'Врач успешно удалён.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def doctor_params
      params.require(:doctor).permit(:name, :specialty, :phone, :description, :image)
    end
end
