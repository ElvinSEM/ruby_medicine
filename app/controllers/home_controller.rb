class HomeController < ApplicationController
   # before_action :authenticate_user! # Это требует аутентификации для действия index

  def index
    @reviews = Review.all
    @doctors = Doctor.all
    @services = Service.all

  end
end
