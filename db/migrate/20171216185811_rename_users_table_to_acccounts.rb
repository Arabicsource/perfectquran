class RenameUsersTableToAcccounts < ActiveRecord::Migration[5.1]
  def change
    rename_table :users, :accounts
  end
end
