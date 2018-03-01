class DropQuranPrefix < ActiveRecord::Migration[5.2]
  def change
    rename_table :quran_ayahs, :ayahs
    drop_table :quran_bookmarks
    rename_table :quran_daily_ayahs, :daily_ayahs
    rename_table :quran_languages, :languages
    rename_table :quran_surahs, :surahs
    rename_table :quran_translations, :translations
    rename_table :quran_texts, :texts
  end
end
