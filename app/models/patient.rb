class Patient < ApplicationRecord
    belongs_to :user
    has_many :appointments
    has_many :doctors, through: :appointments

    validates :name, presence: true
    validates :phone, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
#Имеет множество приемов (appointments).
# Может иметь множество врачей через приемы.