class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :permalink

      t.timestamps
    end
    add_index :categories, :permalink, unique: true
  end
end
