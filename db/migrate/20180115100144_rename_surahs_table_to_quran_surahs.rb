class RenameSurahsTableToQuranSurahs < ActiveRecord::Migration[5.1]
  def change
    rename_table :surahs, :quran_surahs
  end
end
