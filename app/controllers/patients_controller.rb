class PatientsController < ApplicationController
  before_action :set_patient, only: %i[ show edit update destroy ]

  # GET /patients
  def index
    @patients = Patient.all
  end

  # GET /patients/1
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  def create
    @patient = Patient.new(patient_params)

    if @patient.save
      redirect_to @patient, notice: "Patient was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /patients/1
  def update
    if @patient.update(patient_params)
      redirect_to @patient, notice: "Patient was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /patients/1
  def destroy
    @patient.destroy
    redirect_to patients_url, notice: "Patient was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def patient_params
      params.require(:patient).permit(:name, :phone, :email)
    end
end
