FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }  # Автоматически генерирует уникальное имя пользователя
    email { 'test@example.com' }
    password { 'password' }
  end
end