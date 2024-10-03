class Review < ApplicationRecord
  belongs_to :doctor, optional: true
  belongs_to :user

  validates :name, presence: true
  validates :body, presence: true
  validates :user, presence: true
  validates :doctor, presence: true, if: -> { !site_review }  # Требуем доктора, если это не отзыв на сайт

  # Scope to get reviews for the site
  scope :site_reviews, -> { where(site_review: true) }

  # Scope to get reviews for doctors
  scope :doctor_reviews, -> { where(site_review: false) }
end
