class Prescription < ApplicationRecord
  belongs_to :doctor
  belongs_to :nurse
  belongs_to :patient
  belongs_to :assignable, polymorphic: true
end
