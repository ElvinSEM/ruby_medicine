# # class Appointment < ApplicationRecord
# #   belongs_to :doctor
# #   belongs_to :user
# #
# #   validates :start_time, presence: true
# #   validate :time_slot_available
# #
# #   PROBLEMS = {
# #     0 => "Проблема или заболевание",
# #     1 => "Постоянно устают глаза",
# #     3 => "Близорукость",
# #     4 => "Дальнозоркость",
# #     5 => "Глаукома",
# #     6 => "Катаракта",
# #     7 => "Конъюнктивит",
# #     8 => "Другое",
# #   }.freeze
# #
# #   def problem_description
# #     PROBLEMS[self.problem_id]
# #   end
# #
# #   private
# #
# #   def time_slot_available
# #     # Определяем временной диапазон для слота в 30 минут
# #     time_slot_start = start_time
# #     time_slot_end = start_time + 30.minutes
# #
# #     # Проверяем, есть ли записи у данного врача в этот же день, которые перекрывают новый слот
# #     overlapping_appointments = Appointment.where(doctor_id: doctor_id)
# #                                           .where.not(id: id)
# #                                           .where("start_time < ? AND ? < start_time + INTERVAL 30 MINUTE",
# #                                                  time_slot_end, time_slot_start)
# #
# #     # Если найдены пересекающиеся записи, добавляем ошибку
# #     if overlapping_appointments.exists?
# #       errors.add(:start_time, "Выбранное время уже занято для данной даты и врача")
# #     end
# #   end
# # end
#
# class Appointment < ApplicationRecord
#   before_create :set_default_status
#
#   belongs_to :doctor
#   belongs_to :user
#   enum status: { pending: 0, confirmed: 1, cancelled: 2 }
#
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
#     8 => "Другое"
#   }.freeze
#
#   # Получаем описание проблемы
#   def problem_description
#     PROBLEMS[problem_id] || 'Неизвестная проблема'
#   end
#
#   # Проверка доступности временного слота
#   private
#
#   def set_default_status
#     self.status ||= 'scheduled'  # По умолчанию "scheduled"
#   end
#
#   def time_slot_available
#     time_slot_end = start_time + 30.minutes
#
#     overlapping_appointments = Appointment
#                                  .where(doctor_id: doctor_id)
#                                  .where.not(id: id)  # исключаем текущее редактируемое назначение
#                                  .where('start_time < ? AND ? < start_time + INTERVAL 30 MINUTE', time_slot_end, start_time)
#
#     if overlapping_appointments.exists?
#       errors.add(:start_time, "Выбранное время уже занято для данной даты и врача")
#     end
#   end
# end

#
# class Appointment < ApplicationRecord
#   before_create :set_default_status
#
#   belongs_to :doctor
#   belongs_to :user
#   enum status: { pending: 0, confirmed: 1, cancelled: 2 }
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
#     8 => "Другое"
#   }.freeze
#
#   def problem_description
#     PROBLEMS[problem_id] || 'Неизвестная проблема'
#   end
#
#   private
#
#   def set_default_status
#     self.status ||= 'pending'  # По умолчанию статус "pending"
#   end
#
#   def time_slot_available
#     time_slot_end = start_time + 30.minutes
#     overlapping_appointments = Appointment
#                                  .where(doctor_id: doctor_id)
#                                  .where.not(id: id)
#                                  .where('start_time < ? AND ? < start_time + INTERVAL 30 MINUTE', time_slot_end, start_time)
#
#     if overlapping_appointments.exists?
#       errors.add(:start_time, "Выбранное время уже занято для данной даты и врача")
#     end
#   end
# endclass Appointment < ApplicationRecord
#   # Callbacks
#   before_create :set_default_status
#
#   # Associations
#   belongs_to :doctor
#   belongs_to :user
#
#   # Enum for appointment status
#   enum status: { pending: 0, confirmed: 1, cancelled: 2 }
#
#   # Validations
#   validates :start_time, presence: true
#   validate :time_slot_available, :valid_time_slot
#
#   private
#
#   def time_slot_available
#     if overlapping_appointments.exists?
#       next_free_time = Appointment.next_free_time(doctor, user)
#
#       if next_free_time
#         notify_user(user, "Врач #{doctor.name} занят в это время. Следующее доступное время: #{next_free_time.strftime('%Y-%m-%d %H:%M')}")
#       else
#         notify_user(user, "Врач #{doctor.name} занят в это время и нет доступного времени в течение следующей недели.")
#       end
#
#       errors.add(:start_time, 'Время записи уже занято.')
#     end
#   end
#
#   def overlapping_appointments
#     time_slot_end = start_time + 30.minutes
#     Appointment.where(doctor_id: doctor_id)
#                .where.not(id: id)
#                .where('start_time < ? AND ? < start_time + INTERVAL 30 MINUTE', time_slot_end, start_time)
#   end
#
#   def valid_time_slot
#     unless start_time.min % 30 == 0
#       errors.add(:start_time, 'Время записи должно быть кратным 30 минутам.')
#     end
#   end
#
#   def set_default_status
#     self.status ||= 'pending'
#   end
#
#   # Метод для отправки уведомлений
#   def notify_user(user, message)
#     return Rails.logger.error "Пользователь #{user.username} не имеет Telegram ID. Сообщение не отправлено." unless user.telegram_chat_id.present?
#
#     TelegramService.call(user: user, message: message)
#   end
#
#   # Метод класса для получения следующего свободного времени
#   def self.next_free_time(doctor, user)
#     current_time = Time.current
#     one_week_later = current_time + 1.week
#
#     while current_time < one_week_later
#       if doctor_busy?(doctor, current_time)
#         # Врач занят в это время, идем дальше
#         current_time += 30.minutes
#       else
#         # Врач свободен
#         return current_time
#       end
#     end
#
#     nil
#   end
#
#   # Метод для проверки занятости врача
#   def self.doctor_busy?(doctor, requested_time)
#     Appointment.exists?(doctor_id: doctor.id, start_time: requested_time..(requested_time + 30.minutes))
#   end
# end
class Appointment < ApplicationRecord
  # Callbacks
  before_create :set_default_status

  # Associations
  belongs_to :doctor
  belongs_to :user

  # Enum for appointment status
  enum status: { pending: 0, confirmed: 1, cancelled: 2 }

  # Validations
  validates :start_time, presence: true
  validate :time_slot_available, :valid_time_slot

  PROBLEMS = {
    0 => "Проблема или заболевание",
    1 => "Постоянно устают глаза",
    3 => "Близорукость",
    4 => "Дальнозоркость",
    5 => "Глаукома",
    6 => "Катаракта",
    7 => "Конъюнктивит",
    8 => "Другое"
  }.freeze

  # Устанавливаем статус по умолчанию
  def set_default_status
    self.status ||= 'pending'
  end

  # Описание проблемы
  def problem_description
    PROBLEMS[problem_id] || 'Неизвестная проблема'
  end

  # Метод для проверки, доступен ли таймслот
  def time_slot_available
    if overlapping_appointments.exists?
      errors.add(:start_time, 'Время записи уже занято.')
      notify_user(user, "Доктор #{doctor.name} занят на это время.")

      # Находим ближайшее свободное время
      next_free_time = self.class.next_free_time(doctor)

      # Если найдено ближайшее свободное время, отправляем уведомление пользователю
      if next_free_time
        notify_user(user, "Ближайшее свободное время у врача #{doctor.name}: #{next_free_time.strftime("%Y-%m-%d %H:%M")}.")
      else
        notify_user(user, "Нет доступного времени у врача #{doctor.name} в течение следующей недели.")
      end
    end
  end

  # Метод для поиска пересекающихся записей
  def overlapping_appointments
    time_slot_end = start_time + 30.minutes
    Appointment.where(doctor_id: doctor_id)
               .where.not(id: id)
               .where('start_time < ? AND ? < start_time + INTERVAL 30 MINUTE', time_slot_end, start_time)
  end

  # Метод для проверки кратности времени 30 минутам
  def valid_time_slot
    unless start_time.min % 30 == 0
      errors.add(:start_time, 'Время записи должно быть кратным 30 минутам.')
    end
  end

  # Метод для отправки уведомлений
  def notify_user(user, message)
    return Rails.logger.error "Пользователь #{user.username} не имеет Telegram ID. Сообщение не отправлено." unless user.telegram_chat_id.present?

    TelegramService.call(user: user, message: message)
  end

  class << self
    # Метод для получения следующего свободного времени
    def next_free_time(doctor)
      current_time = Time.current
      one_week_later = current_time + 1.week

      while current_time < one_week_later
        unless doctor_busy?(doctor, current_time)
          return current_time
        end
        current_time += 30.minutes
      end

      nil
    end

    private

    # Метод для проверки занятости врача
    def doctor_busy?(doctor, requested_time)
      Appointment.exists?(doctor_id: doctor.id, start_time: requested_time..(requested_time + 30.minutes))
    end
  end
end
