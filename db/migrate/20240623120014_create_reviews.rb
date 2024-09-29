class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.string :name
      t.text :body
      t.references :doctor, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :site_review

      t.timestamps
    end
  end
end
