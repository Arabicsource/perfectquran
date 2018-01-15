class AddAccountToQuranBookmarks < ActiveRecord::Migration[5.1]
  def change
    add_reference :quran_bookmarks, :account, foreign_key: true
  end
end
