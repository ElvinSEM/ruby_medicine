
# Doctor.create({ name: 'Ali', specialty: 'Dantist', phone: '7978001258'  })
#
# puts 'Success!'
# # db/seeds.rb

# Создание массивов пользователей, врачей и паролей
users = ["user1@mail.com", "user2@mail.com", "user3@mail.com"]
doctors = ["doctor1@mail.com", "doctor2@mail.com", "doctor3@mail.com"]
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
doctors.each_with_index do |doctor, index|
  doctor_objects << Doctor.find_or_create_by!(name: "Doctor #{index + 1}", specialty: doctor, phone: phones[index])
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