class ChangeQuranColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :ayahs, :percent_of_total
    remove_column :ayahs, :percent_of_surah
    rename_column :daily_ayahs, :quran_ayah_id, :ayah_id
    remove_column :surahs, :percent_of_total
  end
end
