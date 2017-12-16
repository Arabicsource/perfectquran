class RenameColumnUserIdToAccountIdOnArticles < ActiveRecord::Migration[5.1]
  def change
    rename_column :articles, :user_id, :account_id
  end
end
