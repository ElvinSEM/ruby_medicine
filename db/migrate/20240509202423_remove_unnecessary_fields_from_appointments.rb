class RemoveUnnecessaryFieldsFromAppointments < ActiveRecord::Migration[7.0]
  def change
    remove_column :appointments, :patient_name, :string
    remove_column :appointments, :phone_number, :string
    remove_column :appointments, :disease, :string
    remove_column :appointments, :name, :string
    remove_column :appointments, :phone, :string
    remove_column :appointments, :email, :string
    remove_column :appointments, :problem_id, :integer
    remove_column :appointments, :info, :text
  end
end
