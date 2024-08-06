class DoctorsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  before_action :set_doctor, only: %i[ show edit update destroy ]
  before_action :authorize_doctor!
  after_action :verify_authorized, except: [:index, :show]

  # GET /doctors
  def index
    @doctors = Doctor.all
  end

  # GET /doctors/1
  def show
    authorize @doctor
    @doctor = Doctor.find(params[:id])
    respond_to do |format|
      format.html # _form.html.erb
      format.json { render json: @doctor }
    end
  end

  # GET /doctors/new
  def new
    @doctor = Doctor.new
    authorize @doctor # Проверяем авторизацию для создания нового доктора

  end

  # GET /doctors/1/edit
  def edit
    @doctor = Doctor.find(params[:id])
    authorize @doctor
  end

  # POST /doctors
  def create
    @doctor = Doctor.new(doctor_params)
    authorize @doctor # Проверяем авторизацию для создания нового доктора

    if @doctor.save
      redirect_to @doctor, notice: t('flash.notice.doctor.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /doctors/1
  def update
    if @doctor.update(doctor_params)
      redirect_to @doctor, notice: t('flash.notice.doctor.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /doctors/1
  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.destroy
    redirect_to doctors_url, notice: t('flash.notice.doctor.destroyed')
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

  def authorize_doctor!
    authorize(@doctor || Doctor)
  end
  # def check_admin
  #   redirect_to root_path, alert: 'Доступ разрешен только администраторам' unless current_user.admin?
  # end

end
