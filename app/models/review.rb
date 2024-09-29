class Review < ApplicationRecord
  belongs_to :doctor, optional: true
  belongs_to :user

  validates :name, presence: true
  validates :body, presence: true
  validates :user, presence: true

  # Scope to get reviews for the site
  scope :site_reviews, -> { where(site_review: true) }

  # Scope to get reviews for doctors
  scope :doctor_reviews, -> { where(site_review: false) }
end
