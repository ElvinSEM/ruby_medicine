class ServicesController < ApplicationController
  before_action :authenticate_user! # Предполагаем, что используется Devise для аутентификации
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin!, only: [:new, :create, :edit, :update, :destroy]

  # Обработка ошибки ActiveRecord::RecordNotFound
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @services = Service.all
  end

  def show
  end

  def new
    @service = Service.new
  end

  def edit
    @service = Service.find(params[:id])
  end

  def create
    @service = Service.new(service_params)

    if @service.save
      redirect_to @service, notice: 'Service was successfully created.'
    else
      render :new
    end
  end

  def update
    if @service.update(service_params)
      redirect_to @service, notice: 'Service was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @service.destroy
      redirect_to services_url, notice: 'Service was successfully destroyed.'
    else
      redirect_to services_url, alert: 'There was a problem destroying the service.'
    end
  end

  private
  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :description, :price, :image)
  end

  # Authorization check for admin
  def authorize_admin!
    redirect_to root_path, alert: 'Доступ разрешен только администраторам' unless current_user.admin?
  end

  def record_not_found
    flash[:alert] = 'Service not found.'
    redirect_to services_url
  end

end
