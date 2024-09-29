class AddTelegramChatIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :telegram_chat_id, :string
  end
end
