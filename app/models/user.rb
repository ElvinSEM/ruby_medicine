class User < ApplicationRecord
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
           :omniauthable, omniauth_providers: %i[ google_oauth2]

    has_many :appointments
    has_many :doctors, through: :appointments
    has_many :reviews
    has_many :appointments
    has_many :doctors, through: :appointments

    validates :phone, presence: true, uniqueness: true #format: { with: /A+d{10,15}z/ }
    validates :username, presence: true

    def admin?
        role == 'admin'
    end

    def self.from_google(auth)
        user = find_by(provider: auth.provider, uid: auth.uid)
        return user if user

        create(
          provider: auth.provider,
          uid: auth.uid,
          email: auth.info.email,
          password: Devise.friendly_token[0, 20],
          #full_name: auth.info.name,
          #avatar_url: auth.info.image
        )

        UserMailer.welcome_email(user).deliver_later
        user
    end
end
