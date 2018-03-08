class CreateJuzMemories < ActiveRecord::Migration[5.2]
  def change
    create_table :juz_memories do |t|
      t.references :account, foreign_key: true
      t.references :juz, foreign_key: true
      t.integer :character_length

      t.timestamps
    end
  end
end
