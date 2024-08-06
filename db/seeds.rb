#
# # Doctor.create({ name: 'Ali', specialty: 'Dantist', phone: '7978001258'  })
# #
# # puts 'Success!'
# # # db/seeds.rb
#
# # db/seeds.rb
#
# # db/seeds.rb
#
# # Создание массивов пользователей, врачей, паролей и телефонов
# users = ["user1@mail.com", "user2@mail.com", "user3@mail.com"]
# doctors = ["Oftalmology", "Cardiology", "Dermatology"]
# passwords = ["password1", "password2", "password3"]
# phones = ["1234567890", "0987654321", "1122334455"]
#
# # Описание для врачей
# descriptions = [
#   "Врач высшей категории\nОкончил Андижанский медицинский университет в 1986 году. В 1987 году окончил интернатуру по специальности «Офтальмология».
# \nВрач высшей категории. Заслуженный врач РК.\nРаботает в клинике Генезис с 2002 года.\nКонференции по офтальмологии:
# \n2006 г. — Лондон, Великобритания;\n2007 г. — Верона, Италия;\n2008 г. — Анталия, Турция;\n2009 г. — Барселона, Испания;
# \n2010 г. — Париж, Франция;\n2011 г. — Вена, Австрия.\nЧлен Ассоциации офтальмологов Европы, Член Ассоциации офтальмологов Украины.
# \n2020 год подтверждение квалификации специалиста по направлению подготовки «Офтальмология».",
#   "5Самарский государственный медицинский университет — Травматология и ортопедия, 2006 г.
#  Институт последипломного образования — Травматология и ортопедия, 2004 г. Самарский государственный медицинский университет — Лечебное дело, 2003 г.
# Повышение квалификации: Кинезитейпирование в травматологии и спортивной медицине. Миофасциальный релиз III ступень,
# Непрямой массаж и мягкие мануальные техники Миофасциальный релиз II ступень, Миофасциальный релиз I ступень, Диагностика и лечение ХЗВ в фокусе Международных рекомендаций,
# Современное лечение травматолого-ортопедических больных. Ортезирование стоп по системе ФормТотикс, Радиационная безопасность,
# Хирургия повреждений грудного и пояснично-крестцового отделов позвоночника, Клиническая трансфузиологрия, Современные перевязочные материалы,
#  Актуальные вопросы вертебрологии,",
#   "5 лет специалистом по дерматологии"
# ]
#
# # Создание пользователей, если они еще не существуют
# user_objects = users.each_with_index.map do |user_email, index|
#   user = User.find_or_initialize_by(email: user_email)
#   user.username = "User #{index + 1}"
#   user.password = passwords[index]
#   user.phone = phones[index]
#
#   # Назначаем роли пользователям
#   user.role = index == 0 ? 'admin' : 'user' # Первый пользователь будет администратором, остальные - обычными пользователями
#
#   user.save!
#   user
# end
#
# # Создание врачей, если они еще не существуют
# doctor_objects = doctors.each_with_index.map do |specialty, index|
#   Doctor.find_or_create_by!(name: "Doctor #{index + 1}", specialty: specialty, phone: phones[index], description: descriptions[index])
# end
#
# # Создание записей
# problems = ["Проблема или заболевание", "Постоянно устают глаза", "Близорукость", "Дальнозоркость", "Глаукома", "Катаракта", "Конъюнктивит", "Другое"]
#
# # Пробегаем по каждому пользователю и доктору, создавая записи
# user_objects.each do |user|
#   doctor_objects.each do |doctor|
#     problems.each do |problem|
#       # Теперь при создании записи мы также связываем ее с пользователем и врачом и указываем start_time
#       Appointment.find_or_create_by!(
#         info: problem,
#         doctor: doctor,
#         user: user,
#         start_time: DateTime.now + rand(1..30).days # Случайное время в пределах следующих 30 дней
#       )
#     end
#   end
# end
#
#
#
# # Добавляем новые услуги
# services = Service.create([
#                             { name: 'Диагностика зрения', description: 'Полная диагностика зрения с использованием современного оборудования', price: 1200.00 },
#                             { name: 'Лечение заболеваний глаз', description: 'Комплексное лечение заболеваний глаз различной сложности', price: 3000.00 },
#                             { name: 'Операции на глаза', description: 'Высокотехнологичные операции на глаза, включая лазерную коррекцию', price: 25000.00 },
#                             { name: 'Коррекция зрения', description: 'Коррекция зрения с использованием современных методик и оборудования', price: 15000.00 }
#                           ])
#
# puts "Добавлено #{services.size} новых услуг."
#
#
# services = Service.create([
#                              {
#                                name: Faker::Lorem.sentence(word_count: 3),  # Генерация названия услуги
#                                description: Faker::Lorem.paragraph(sentence_count: 2),  # Генерация описания услуги
#                                price: Faker::Commerce.price  # Генерация цены
#                              },
#                            #...создаем столько услуг, сколько вам нужно
#                            ])
# puts "Добавлено #{services.size} новых услуг."
# # Убедитесь, что в вашей таблице users есть хотя бы одна запись
# user = User.first
#
# # Создаём отзывы для каждого врача
# Doctor.all.each do |doctor|
#   2.times do
#     doctor.reviews.create!(
#       name: Faker::Name.name,
#       body: Faker::Quote.famous_last_words,
#       user_id: user.id,  # Сюда мы передаем id пользователя
#       site_review: false  # Указываем, что это отзыв о враче, а не о сайте
#     )
#   end
# end
# puts "Добавлено #{Review.where(site_review: false).count} отзыва доктора"
#
# # Создаём общие отзывы о сайте
# 3.times do
#   user.reviews.create!(
#     name: Faker::Name.name,
#     body: Faker::Quote.famous_last_words,
#     site_review: true,  # Указываем, что это отзыв о сайте
#     doctor_id: nil  # Так как это общий отзыв о сайте, doctor_id устанавливаем в nil
#   )
#
# end
# puts "Добавлено #{Review.where(site_review: true).count} отзывов о сайте"
#

require 'faker'

# Создание администратора
admin = User.create!(
  email: 'user1@mail.com',
  password: 'password1',
  username: 'Admin User',
  phone: Faker::PhoneNumber.phone_number,
  role: 'admin'
)

# Создание пользователей
users = 9.times.map do |i|
  User.create!(
    email: Faker::Internet.email,
    password: 'password',
    username: Faker::Name.name,
    phone: Faker::PhoneNumber.phone_number,
    role: 'user'
  )
end

# Добавление администратора в массив пользователей для удобства
users << admin

# Создание врачей
doctors = 5.times.map do
  Doctor.create!(
    name: Faker::Name.name,
    specialty: Faker::Job.field,
    phone: Faker::PhoneNumber.phone_number,
    description: Faker::Lorem.paragraph
  )
end

# Создание услуг
services = 10.times.map do
  Service.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Commerce.price
  )
end

# Создание записей на прием
problems = ["Проблема или заболевание", "Постоянно устают глаза", "Близорукость", "Дальнозоркость", "Глаукома", "Катаракта", "Конъюнктивит", "Другое"]

users.each do |user|
  doctors.each do |doctor|
    problems.each do |problem|
      Appointment.create!(
        info: problem,
        doctor: doctor,
        user: user,
        start_time: DateTime.now + rand(1..30).days  # Случайное время в пределах следующих 30 дней
      )
    end
  end
end

# Создание отзывов
doctors.each do |doctor|
  2.times do
    doctor.reviews.create!(
      name: Faker::Name.name,
      body: Faker::Quote.famous_last_words,
      user: users.sample,
      site_review: false
    )
  end
end

# Создание общих отзывов о сайте
3.times do
  users.sample.reviews.create!(
    name: Faker::Name.name,
    body: Faker::Quote.famous_last_words,
    site_review: true
  )
end

puts "База данных успешно заполнена фейковыми данными!"
