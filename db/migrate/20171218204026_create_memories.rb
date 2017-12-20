class CreateMemories < ActiveRecord::Migration[5.1]
  def change
    create_table :memories do |t|
      t.references :account, foreign_key: true
      t.references :ayah, foreign_key: true

      t.timestamps
    end
  end
end
