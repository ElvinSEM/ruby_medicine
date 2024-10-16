class ChangeForeignKeyOnReviews < ActiveRecord::Migration[7.0]
  def change
    # Удалить старый внешний ключ, если он есть
    remove_foreign_key :reviews, :users

    # Добавить новый внешний ключ с опцией каскадного удаления
    add_foreign_key :reviews, :users, on_delete: :cascade
  end
end
