class CreateAccountTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :account_translations do |t|
      t.references :account, foreign_key: true
      t.references :translation, foreign_key: true
      t.integer :order, default: 0
      t.boolean :primary, default: false

      t.timestamps
    end
  end
end
