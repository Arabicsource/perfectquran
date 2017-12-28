class AddCustomerTokenToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :customer_token, :string
    add_column :subscriptions, :subscription_token, :string
  end
end
