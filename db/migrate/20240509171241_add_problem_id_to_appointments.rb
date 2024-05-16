class AddProblemIdToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :problem_id, :integer
  end
end
