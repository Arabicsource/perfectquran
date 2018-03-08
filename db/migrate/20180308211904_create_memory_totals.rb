class CreateMemoryTotals < ActiveRecord::Migration[5.2]
  def change
    create_table :memory_totals do |t|
      t.references :account, foreign_key: true
      t.integer :surah_count, default: 0
      t.integer :page_count, default: 0
      t.integer :juz_count, default: 0
      t.integer :character_length, default: 0

      t.timestamps
    end
  end
end
