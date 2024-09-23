# # class Doctor < ApplicationRecord
# #   has_many :appointments
# #   has_many :users, through: :appointments
# #   has_one_attached :image
# #   has_many :reviews
# #   has_many :appointments, dependent: :destroy
# #   has_many :reviews, dependent: :destroy
# #
# # # has_many :patients, through: :appointments
# #
# #
# #   validates :name, presence: true
# #   validates :specialty, presence: true
# # end
# # #Имеет множество приемов (appointments).
# # # Может иметь множество пациентов через приемы.
#
# class Doctor < ApplicationRecord
#   has_many :appointments
#   has_many :users, through: :appointments
#   has_one_attached :image
#   has_many :reviews
#   has_many :appointments, dependent: :destroy
#   has_many :reviews, dependent: :destroy
#
#   validates :name, presence: true
#   validates :specialty, presence: true
#
#   # Проверяем занятость врача на определенную дату
#   def available_on?(date)
#     appointments.where(appointment_date: date).none?
#   end
#
#   # Метод для получения ближайшей свободной даты
#   def next_available_date
#     upcoming_dates = (Date.today..(Date.today + 30.days)).to_a
#     upcoming_dates.find { |date| available_on?(date) }
#   end
# end



class Doctor < ApplicationRecord
  has_many :appointments
  has_many :users, through: :appointments
  has_one_attached :image
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :specialty, presence: true

  def available_on?(date)
    appointments.where(appointment_date: date).none?
  end

  def next_available_date
    upcoming_dates = (Date.today..(Date.today + 30.days)).to_a
    upcoming_dates.find { |date| available_on?(date) }
  end
end
