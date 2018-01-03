class AddStatusToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :status, :string
    add_column :subscriptions, :payment_brand, :string
    add_column :subscriptions, :payment_last4, :string
    add_column :subscriptions, :current_period_end, :string
  end
end
