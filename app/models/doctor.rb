class Doctor < ApplicationRecord
  has_many :appointments
  has_many :users, through: :appointments
  has_many :patients, through: :appointments


  validates :name, presence: true
  validates :specialty, presence: true
end
#Имеет множество приемов (appointments).
# Может иметь множество пациентов через приемы.