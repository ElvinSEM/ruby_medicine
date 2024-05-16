class AddInfoAndProblemIdToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :info, :string
    add_column :appointments, :problem_id, :integer
  end
end
