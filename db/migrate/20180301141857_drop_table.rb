class DropTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :thredded_private_users
  end
end
