class CreatePageMemories < ActiveRecord::Migration[5.2]
  def change
    create_table :page_memories do |t|
      t.references :account, foreign_key: true
      t.references :page, foreign_key: true
      t.integer :character_length

      t.timestamps
    end
  end
end
