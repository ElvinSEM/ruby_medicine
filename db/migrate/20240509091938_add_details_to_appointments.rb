class AddDetailsToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :patient_name, :string
    add_column :appointments, :phone_number, :string
    add_column :appointments, :disease, :string
    add_column :appointments, :problem_description, :text
  end
end
