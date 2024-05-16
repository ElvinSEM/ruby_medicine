class FixUserPasswordDigest < ActiveRecord::Migration[6.0]
      def change
        rename_column :users, :digest, :password_digest
        remove_column :users, :password_, :string
      end
end

