class Appointment < ApplicationRecord
  # Callbacks
  before_create :set_default_status

  # Associations
  belongs_to :doctor
  belongs_to :user

  # Enum for appointment status
  enum status: { pending: 0, confirmed: 1, cancelled: 2 }

  # Validations
  validates :appointment_date, presence: true
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
      errors.add(:appointment_date, 'Время записи уже занято.')
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
    time_slot_end = appointment_date + 30.minutes
    Appointment.where(doctor_id: doctor_id)
               .where.not(id: id)
               .where('appointment_date < ? AND ? < appointment_date + INTERVAL \'30 minutes\'', time_slot_end, appointment_date)
  end

  # Метод для проверки кратности времени 30 минутам
  def valid_time_slot
    unless appointment_date.min % 30 == 0
      errors.add(:appointment_date, 'Время записи должно быть кратным 30 минутам.')
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
      Appointment.exists?(doctor_id: doctor.id, appointment_date: requested_time..(requested_time + 30.minutes))
    end
  end
end
