
# Doctor.create({ name: 'Ali', specialty: 'Dantist', phone: '7978001258'  })
#
# puts 'Success!'
# # db/seeds.rb

# Создание массивов пользователей, врачей и паролей
users = ["user1@mail.com", "user2@mail.com", "user3@mail.com"]
doctors = ["Oftalmology", "Cardiology", "Dermatology"]
passwords = ["password1", "password2", "password3"]
phones = ["1234567890", "0987654321", "1122334455"]

# Объекты пользователей и врачей
user_objects = []
doctor_objects = []

# Создание пользователей, если они еще не существуют
users.each_with_index do |user, index|
  User.find_or_create_by!(username: "User #{index + 1}", email: user) do |user|
    user.password = passwords[index]
    user.phone = phones[index]
  end
end


# Создание врачей, если они еще не существуют
description = ["Врач высшей категории
Окончил Андижанский медицинский университет в 1986 году. В 1987 году окончил интернатуру по специальности «Офтальмология».
Врач высшей категории. Заслуженный врач РК.
Работает в клинике Генезис с 2002 года.
Конференции по офтальмологии:
2006 г. — Лондон, Великобритания;
2007 г. — Верона, Италия;
2008 г. — Анталия, Турция;
2009 г. — Барселона, Испания;
2010 г. — Париж, Франция;
2011 г. — Вена, Австрия.
Член Ассоциации офтальмологов Европы, Член Ассоциации офтальмологов Украины.
2020 год подтверждение квалификации специалиста по направлению подготовки «Офтальмология».", "5 лет специалистом по кардиологии", "5 лет специалистом по дермотологии"]
doctors.each_with_index do |doctor, index|
  doctor_objects << Doctor.find_or_create_by!(name: "Doctor #{index + 1}", specialty: doctor, phone: phones[index], description: description[index])
end

# Создание записей
problems = ["Проблема или заболевание", "Постоянно устают глаза", "Близорукость", "Дальнозоркость", "Глаукома", "Катаракта", "Конъюнктивит", "Другое"]

# Пробегаем по каждому пользователю и доктору, создавая записи
user_objects.each do |user|
  doctor_objects.each do |doctor|
    problems.each do |problem|
      # Теперь при создании записи мы также связываем ее с пользователем и врачом
      Appointment.find_or_create_by!(info: problem, doctor: doctor, user: user)
    end
  end
end



# Добавляем новые услуги
services = Service.create([
                            { name: 'Диагностика зрения', description: 'Полная диагностика зрения с использованием современного оборудования', price: 1200.00 },
                            { name: 'Лечение заболеваний глаз', description: 'Комплексное лечение заболеваний глаз различной сложности', price: 3000.00 },
                            { name: 'Операции на глаза', description: 'Высокотехнологичные операции на глаза, включая лазерную коррекцию', price: 25000.00 },
                            { name: 'Коррекция зрения', description: 'Коррекция зрения с использованием современных методик и оборудования', price: 15000.00 }
                          ])

puts "Добавлено #{services.size} новых услуг."


sservices = Service.create([
                             {
                               name: Faker::Lorem.sentence(word_count: 3),  # Генерация названия услуги
                               description: Faker::Lorem.paragraph(sentence_count: 2),  # Генерация описания услуги
                               price: Faker::Commerce.price  # Генерация цены
                             },
                           #...создаем столько услуг, сколько вам нужно
                           ])
puts "Добавлено #{services.size} новых услуг."

# Создание общих отзывов о сайте
3.times do
  Review.create(
    name: Faker::Name.name, # Используйте name вместо comment
    body: Faker::Quote.famous_last_words,
    )
end

# Создание отзывов о врачах
Doctor.all.each do |doctor|
  2.times do
    doctor.reviews.create(
      name: Faker::Name.name, # Используйте name вместо comment
      body: Faker::Quote.famous_last_words,
    )
  end
end
