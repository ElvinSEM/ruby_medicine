class User < ApplicationRecord
    devise :database_authenticatable, :registerable,
                  :recoverable, :rememberable, :validatable
    has_many :appointments
    has_many :doctors, through: :appointments
    # has_one :patient, dependent: :destroy
    # accepts_nested_attributes_for :patient
    validates :phone, presence: true, uniqueness: true #format: { with: /A+d{10,15}z/ }
    # Валидация наличия username
    validates :username, presence: true
    has_many :appointments
    has_many :doctors, through: :appointments

end

