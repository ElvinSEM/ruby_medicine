# class Appointment < ApplicationRecord
#   belongs_to :doctor
#   belongs_to :user
#
#   validates :start_time, presence: true
#   validate :time_slot_available
#
#   PROBLEMS = {
#     0 => "Проблема или заболевание",
#     1 => "Постоянно устают глаза",
#     3 => "Близорукость",
#     4 => "Дальнозоркость",
#     5 => "Глаукома",
#     6 => "Катаракта",
#     7 => "Конъюнктивит",
#     8 => "Другое",
#   }.freeze
#
#   def problem_description
#     PROBLEMS[self.problem_id]
#   end
#   # Проверка, что запись начинается через час
#   def self.appointments_in_an_hour
#     where(start_time: 1.hour.from_now..1.hour.from_now.end_of_hour)
#   end
#   private
#
#   def time_slot_available
#     # Проверяем, существует ли запись на ту же дату и время для того же врача
#     if Appointment.where(doctor_id: doctor_id, start_time: start_time.to_datetime.beginning_of_day..start_time.to_datetime.end_of_day).where.not(id: id).exists?
#       errors.add(:start_time, "Выбранное время уже занято для данной даты и врача")
#     end
#   end
# end


#
# class Appointment < ApplicationRecord
#   belongs_to :doctor
#   belongs_to :user
#
#   validates :start_time, presence: true
#   validate :time_slot_available
#
#   PROBLEMS = {
#     0 => "Проблема или заболевание",
#     1 => "Постоянно устают глаза",
#     3 => "Близорукость",
#     4 => "Дальнозоркость",
#     5 => "Глаукома",
#     6 => "Катаракта",
#     7 => "Конъюнктивит",
#     8 => "Другое",
#   }.freeze
#
#   def problem_description
#     PROBLEMS[self.problem_id]
#   end
#   # Метод для получения времени в пользовательском часовом поясе
#   def start_time_in_user_time_zone
#     start_time.in_time_zone('Moscow')
#   end
#
#   # Проверка, что запись начинается через час
#   def self.appointments_in_an_hour
#     now = Time.current
#     where(start_time: now + 30.minutes..now + 1.hour)
#   end
#
#   # def time_slot_available
#   #   if Appointment.where(doctor_id: doctor_id, start_time: start_time.beginning_of_day..start_time.end_of_day)
#   #                 .where.not(id: id).exists?
#   #     errors.add(:start_time, "Выбранное время уже занято для данной даты и врача")
#   #   end
#   # end
#   private
#
#   def convert_start_time_to_utc
#     self.start_time = start_time.in_time_zone('Moscow').utc
#   end
#   def time_slot_available
#     if Appointment.where(doctor_id: doctor_id, start_time: start_time.to_datetime.beginning_of_day..start_time.to_datetime.end_of_day).where.not(id: id).exists?
#       errors.add(:start_time, "Выбранное время уже занято для данной даты и врача")
#     end
#   end
# end


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

  # def start_time_in_user_time_zone
  #   start_time.in_time_zone('Moscow')
  # end

  # def self.appointments_in_an_hour
  #   now = Time.current
  #   where(start_time: now + 30.minutes..now + 1.hour)
  # end

  private

  def time_slot_available
    # Определяем временной диапазон для слота в 30 минут
    time_slot_start = start_time
    time_slot_end = start_time + 30.minutes

    # Проверяем, есть ли записи у данного врача в этот же день, которые перекрывают новый слот
    overlapping_appointments = Appointment.where(doctor_id: doctor_id)
                                          .where.not(id: id)
                                          .where("start_time < ? AND ? < start_time + INTERVAL 30 MINUTE",
                                                 time_slot_end, time_slot_start)

    # Если найдены пересекающиеся записи, добавляем ошибку
    if overlapping_appointments.exists?
      errors.add(:start_time, "Выбранное время уже занято для данной даты и врача")
    end
  end

  # def convert_start_time_to_utc
  #   self.start_time = start_time.in_time_zone('Moscow').utc
  # end
end
