class Appointment < ApplicationRecord
  attr_accessor :problem_description
  PROBLEMS = {
    0 => "Проблема или заболевание",
    1 => "Постоянно устают глаза",
    3 => "Близорукость",
    4 => "Дальнозоркость",
    5 => "Глаукома",
    6 => "Катаракта",
    7 => "Конъюнктивит",
    8 => "Другое",
  }.freeze

  def problem_description
    PROBLEMS[problem_id]
  end


  belongs_to :doctor
  # belongs_to :patient
  belongs_to :user
  #
  # validates :appointment_date, presence: true
  validates :status, presence: true
  # Установка значения по умолчанию для статуса, если это необходимо
  before_validation :set_default_status, on: :create

  private

  def set_default_status
    self.status ||= 'запланировано'
  end
end

#Принадлежит врачу (doctor).
# Принадлежит пациенту (patient).