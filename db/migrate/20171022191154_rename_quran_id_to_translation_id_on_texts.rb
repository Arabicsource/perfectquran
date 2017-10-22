class RenameQuranIdToTranslationIdOnTexts < ActiveRecord::Migration[5.1]
  def change
    rename_column :texts, :quran_id, :translation_id
  end
end
