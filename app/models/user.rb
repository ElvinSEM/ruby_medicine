class User < ApplicationRecord
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
           :omniauthable, omniauth_providers: %i[ google_oauth2]

    has_many :appointments, dependent: :destroy
    has_many :doctors, through: :appointments
    has_many :reviews
    has_many :doctors, through: :appointments

    # validates :phone, presence: true, uniqueness: true #format: { with: /A+d{10,15}z/ }
    # validates :username, presence: true
    validates :phone, presence: true, uniqueness: true unless Rails.env.test?
    validates :email, presence: true, uniqueness: true
    validates :username, presence: true

    def admin?
        role == 'admin'
    end

    def self.from_google(auth)
        puts "from_google called with auth: #{auth.inspect}"

        user = find_by(provider: auth.provider, uid: auth.uid)
        return user if user

        # Используем `new` вместо `create` чтобы сначала инициализировать объект
        user = new(
          provider: auth.provider,
          uid: auth.uid,
          email: auth.info.email,
          password: Devise.friendly_token[0, 20],
          username: auth.info.username,
          phone: '0000000000'  # Значение по умолчанию для phone
        )

        puts "User initialized: #{user.inspect}" # Отладочный вывод

        if user.save
            puts "User saved successfully"
            UserMailer.welcome_email(user).deliver_later
        else
            puts "User failed to save: #{user.errors.full_messages}"
            Rails.logger.debug(user.errors.full_messages)  # Логирование ошибок
        end

        user
    end

end
