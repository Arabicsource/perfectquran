class CreateQuranBookmarks < ActiveRecord::Migration[5.1]
  def change
    create_table :quran_bookmarks do |t|
      t.references :bookmarkable, polymorphic: true

      t.timestamps
    end

    add_index :quran_bookmarks, [:bookmarkable_id, :bookmarkable_type]
  end
end
