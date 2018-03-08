class AddJuzIdToAyahs < ActiveRecord::Migration[5.2]
  def change
    add_reference :ayahs, :juz, foreign_key: true
  end
end
