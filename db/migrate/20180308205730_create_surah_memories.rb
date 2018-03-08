class CreateSurahMemories < ActiveRecord::Migration[5.2]
  def change
    create_table :surah_memories do |t|
      t.references :account, foreign_key: true
      t.references :surah, foreign_key: true
      t.integer :character_length

      t.timestamps
    end
  end
end
