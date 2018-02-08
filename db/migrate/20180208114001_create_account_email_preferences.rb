class CreateAccountEmailPreferences < ActiveRecord::Migration[5.2]
  def change
    create_table :account_email_preferences do |t|
      t.references :account, foreign_key: true
      t.boolean :general

      t.timestamps
    end
  end
end
