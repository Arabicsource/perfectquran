class RenameColumnUserIdToAccountIdOnBookmarks < ActiveRecord::Migration[5.1]
  def change
    rename_column :bookmarks, :user_id, :account_id
  end
end
