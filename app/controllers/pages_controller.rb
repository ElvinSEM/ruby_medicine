# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def search
    @query = params[:query]

    # Обработка пустого или nil запроса
    if @query.blank?
      flash[:alert] = "Введите запрос для поиска."
      redirect_to root_path
      return
    end

    @doctors = Doctor.where("name LIKE ? OR specialty LIKE ?", "%#{@query}%", "%#{@query}%")
    @reviews = Review.where("name LIKE ? OR body LIKE ?", "%#{@query}%", "%#{@query}%")
    @services = Service.where("name LIKE ? OR description LIKE ?", "%#{@query}%", "%#{@query}%")
    @appointments = Appointment.where("info LIKE ? OR problem_description LIKE ?", "%#{@query}%", "%#{@query}%")
    @users = User.where("username LIKE ? OR email LIKE ?", "%#{@query}%", "%#{@query}%")
  end
end
