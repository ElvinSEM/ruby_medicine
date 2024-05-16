class HomeController < ApplicationController
   # before_action :authenticate_user! # Это требует аутентификации для действия index

  def index
    @doctors = Doctor.limit(4)

  end
end
