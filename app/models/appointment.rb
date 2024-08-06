class Appointment < ApplicationRecord

  belongs_to :doctor
  belongs_to :user

  validates :start_time, presence: true
  validate :time_slot_available

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
    PROBLEMS[self.problem_id]
  end
  def time_slot_available
    if Appointment.exists?(doctor_id: doctor_id, start_time: start_time)
      errors.add(:start_time, "Выбранное время уже занято")
    end
  end
end