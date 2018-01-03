class CreateCharges < ActiveRecord::Migration[5.1]
  def change
    create_table :charges do |t|
      t.references :account, foreign_key: true
      t.integer :amount_in_cents
      t.string :payment_brand
      t.string :payment_last4

      t.timestamps
    end
  end
end
