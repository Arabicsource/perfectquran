class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.integer :character_length
      t.references :juz, foreign_key: true
    end
  end
end
