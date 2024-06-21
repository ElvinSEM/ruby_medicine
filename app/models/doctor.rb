class Doctor < ApplicationRecord
  has_many :appointments
  has_many :users, through: :appointments
  has_one_attached :image
  has_many :reviews
  has_many :appointments, dependent: :destroy
  has_many :reviews, dependent: :destroy

# has_many :patients, through: :appointments


  validates :name, presence: true
  validates :specialty, presence: true
end
#Имеет множество приемов (appointments).
# Может иметь множество пациентов через приемы.