class RenameColumnUserIdToAccountIdOnComments < ActiveRecord::Migration[5.1]
  def change
    rename_column :comments, :user_id, :account_id
  end
end
