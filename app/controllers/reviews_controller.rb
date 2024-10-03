# frozen_string_literal: true

class ReviewsController < ApplicationController
  # Ограничиваем доступ к действиям аутентифицированными пользователями
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_review, only: %i[show edit update destroy]
  after_action :verify_authorized, except: %i[index show]
  before_action :add_default_breadcrumbs, only: %i[index show new edit]

  def index
    add_breadcrumb "Reviews", reviews_path

    # Получаем только 3 отзыва для показа
    @reviews = policy_scope(Review).limit(3)
  end

  def show_all

    @reviews = policy_scope(Review)
    authorize @reviews # Убедитесь, что у вас есть соответствующая политика для массива
    render :index
  end

  def show
    add_breadcrumb "Reviews", reviews_path

    authorize @review
  end

  def new
    @review = Review.new
    authorize @review
  end

  def edit
    add_breadcrumb "Reviews", reviews_path

    authorize @review
  end

  def create
    # Создаем новый отзыв и присваиваем текущего пользователя
    @review = current_user.reviews.new(review_params)
    authorize @review  # Проверка авторизации перед сохранением
    if @review.save
      redirect_to reviews_path, notice: t('reviews.create')
    else
      render :new
    end
  end

  def update
    authorize @review

    if @review.update(review_params)
      redirect_to @review, notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @review
    @review.destroy
    redirect_to reviews_url, notice: 'Review was successfully destroyed.'
  end

  private

  def set_review
    @review = Review.find(params[:id])
    authorize @review  # Убедитесь, что вы проверяете права на конкретный отзыв
  end

  def review_params
    params.require(:review).permit(:name, :body, :doctor_id, :site_review)
  end
  def add_default_breadcrumbs
    add_breadcrumb t('breadcrumbs.home'), root_path
    add_breadcrumb t('breadcrumbs.reviews.index'), reviews_path if action_name == 'index'
    add_breadcrumb t('breadcrumbs.reviews.new'), new_review_path if action_name == 'new'
    add_breadcrumb t('breadcrumbs.reviews.edit'), edit_review_path(@review) if action_name == 'edit'
    add_breadcrumb t('breadcrumbs.reviews.show'), review_path(@review) if action_name == 'show'
  end
end
