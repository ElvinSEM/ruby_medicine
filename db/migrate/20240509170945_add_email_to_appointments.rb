class AddEmailToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :email, :string
  end
end
