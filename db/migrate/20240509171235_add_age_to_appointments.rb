class AddAgeToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :age, :integer
  end
end
