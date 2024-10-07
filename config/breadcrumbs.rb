# Главная страница
crumb :root do
  link I18n.t('clinic.navigation.home'), root_path
end

# Услуги
crumb :services do
  link I18n.t('clinic.navigation.services'), services_path
end

# Конкретная услуга
crumb :service do |service|
  link service.name, service_path(service)
  parent :services
end

# О враче
crumb :doctors do
  link I18n.t('clinic.navigation.doctors'), doctors_path
end

# Конкретный врач
crumb :doctor do |doctor|
  link doctor.name, doctor_path(doctor)
  parent :doctors
end


# Отзывы
crumb :reviews do
  link I18n.t('clinic.navigation.reviews'), reviews_path
end

# Конкретный отзыв
crumb :review do |review|
  link review.name, review_path(review)
  parent :reviews
end