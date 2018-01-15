class RenameLanguagesTableToQuranLanguages < ActiveRecord::Migration[5.1]
  def change
    rename_table :languages, :quran_languages
  end
end
