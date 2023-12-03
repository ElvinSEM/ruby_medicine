class CreatePrescriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :prescriptions do |t|
      t.references :doctor, null: false, foreign_key: true
      t.references :nurse, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true
      t.references :assignable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
