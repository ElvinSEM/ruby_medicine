class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: [:index, :show]

  def index
    @reviews = policy_scope(Review).limit(3) # Здесь 5 - количество отзывов для показа
  end

  def show_all
    @reviews = policy_scope(Review)
    authorize @reviews
    render :index # Можно использовать другое представление, если нужно
  end

  def show
    authorize @review
  end

  def new
    @review = Review.new
    authorize @review
  end

  def edit
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    authorize @review

    if @review.save
      redirect_to @review, notice: t('reviews.create')
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
  end

  def review_params
    params.require(:review).permit(:name, :body, :doctor_id, :site_review)
  end
end
