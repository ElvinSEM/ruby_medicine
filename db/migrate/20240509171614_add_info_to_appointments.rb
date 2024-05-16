class AddInfoToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :info, :text
  end
end
