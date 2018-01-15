class RenameTranslationsTableToQuranTranslations < ActiveRecord::Migration[5.1]
  def change
    rename_table :translations, :quran_translations
  end
end
