class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.references :ayah, foreign_key: true
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
