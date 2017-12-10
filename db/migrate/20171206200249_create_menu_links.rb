class CreateMenuLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :menu_links do |t|
      t.string :name
      t.string :path
      t.references :menu, foreign_key: true

      t.timestamps
    end
  end
end
