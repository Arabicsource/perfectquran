class CreateMemories < ActiveRecord::Migration[5.1]
  def change
    create_table :memories do |t|
      t.references :user, foreign_key: true
      t.references :ayah, foreign_key: true

      t.timestamps
    end

    add_index :memories, [:user_id, :ayah_id], unique: true
  end
end
