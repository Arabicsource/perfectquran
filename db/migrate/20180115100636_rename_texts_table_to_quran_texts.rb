class RenameTextsTableToQuranTexts < ActiveRecord::Migration[5.1]
  def change
    rename_table :texts, :quran_texts
  end
end
