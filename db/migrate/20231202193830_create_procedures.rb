class CreateProcedures < ActiveRecord::Migration[7.0]
  def change
    create_table :procedures do |t|
      t.references :nurse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
