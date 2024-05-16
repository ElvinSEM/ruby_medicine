class AddPhoneToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :phone, :string
  end
end
