# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  # Определение ролей
  enum role: { user: '1', admin: '2' }

  # Связи с другими моделями
  has_many :appointments, dependent: :destroy
  has_many :doctors, through: :appointments
  has_many :reviews, dependent: :destroy

  # Валидации
  validates :phone, presence: true, uniqueness: true, unless: -> { Rails.env.test? }
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true

  # Метод для создания пользователя через Google OAuth
  def self.from_google(auth)
    puts "from_google called with auth: #{auth.inspect}"

    # Поиск пользователя по uid и провайдеру
    user = find_by(provider: auth.provider, uid: auth.uid)
    return user if user

    # Инициализация нового пользователя
    user = new(
      provider: auth.provider,
      uid: auth.uid,
      email: auth.info.email,
      password: Devise.friendly_token[0, 20],
      username: auth.info.name || auth.info.email, # Используем имя или email для username
      phone: '0000000000', # Значение по умолчанию для phone
      role: :user # Назначаем роль user по умолчанию
    )

    puts "User initialized: #{user.inspect}" # Отладочный вывод

    if user.save
      puts 'User saved successfully'
      UserMailer.welcome_email(user).deliver_later
    else
      puts "User failed to save: #{user.errors.full_messages}"
      Rails.logger.debug(user.errors.full_messages) # Логирование ошибок
    end

    user
  end
end
