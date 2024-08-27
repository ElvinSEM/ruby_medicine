FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }  # Автоматически генерирует уникальное имя пользователя
    email { 'test@example.com' }
    phone { "1234567890" }
    password { 'password' }
  end
end