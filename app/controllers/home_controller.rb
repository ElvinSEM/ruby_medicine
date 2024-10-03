class HomeController < ApplicationController
   # before_action :authenticate_user! # Это требует аутентификации для действия index

  def index
    add_breadcrumb "Home", :root_path

    @doctors = Doctor.all
    @services = Service.all
    @reviews = Review.limit(3)

  end
end
