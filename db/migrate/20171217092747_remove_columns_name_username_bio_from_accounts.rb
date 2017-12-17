class RemoveColumnsNameUsernameBioFromAccounts < ActiveRecord::Migration[5.1]
  def change
    Account.all.each do |a|
      Profile.create!(account: a, name: a.name, username: a.username, bio: a.bio)
    end

    remove_column :accounts, :name
    remove_column :accounts, :username
    remove_column :accounts, :bio
  end
end
