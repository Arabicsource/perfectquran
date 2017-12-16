class RemoveTimestampsFromTranslations < ActiveRecord::Migration[5.1]
  def change
    remove_column :translations, :created_at, :string
    remove_column :translations, :updated_at, :string
  end
end
