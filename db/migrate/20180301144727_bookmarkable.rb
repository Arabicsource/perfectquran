class Bookmarkable < ActiveRecord::Migration[5.2]
  def change
    rename_column :bookmarks, :ayah_id, :bookmarkable_id
    add_column :bookmarks, :bookmarkable_type, :string
  end
end
