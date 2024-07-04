class User < ApplicationRecord
    devise :database_authenticatable, :registerable,
                  :recoverable, :rememberable, :validatable

    # Метод для проверки, является ли пользователь администратором
    def admin?
        role == 'admin'
    end

    has_many :appointments
    has_many :doctors, through: :appointments
    has_many :reviews

    # has_one :patient, dependent: :destroy
    # accepts_nested_attributes_for :patient
    validates :phone, presence: true, uniqueness: true #format: { with: /A+d{10,15}z/ }
    # Валидация наличия username
    validates :username, presence: true
    has_many :appointments
    has_many :doctors, through: :appointments

end

