class AddPageReferenceToAyahs < ActiveRecord::Migration[5.2]
  def change
    add_reference :ayahs, :page, foreign_key: true
  end
end
