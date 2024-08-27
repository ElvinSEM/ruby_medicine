class HomeController < ApplicationController
   # before_action :authenticate_user! # Это требует аутентификации для действия index

  def index
    @doctors = Doctor.all
    @services = Service.all
    @reviews = Review.limit(3)

  end
end
