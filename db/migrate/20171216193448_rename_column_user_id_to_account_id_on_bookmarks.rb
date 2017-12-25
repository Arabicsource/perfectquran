class RenameColumnUserIdToAccountIdOnBookmarks < ActiveRecord::Migration[5.1]
  def change
    if ActiveRecord::Base.connection.table_exists?  'bookmarks'
      rename_column :bookmarks, :user_id, :account_id 
    end
  end
end
