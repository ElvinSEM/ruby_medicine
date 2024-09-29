class ChangeDoctorIdInReviews < ActiveRecord::Migration[7.0]
  def change
    change_column_null :reviews, :doctor_id, true
  end
end
