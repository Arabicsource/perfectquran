class RemoveTimestampsFromAyahs < ActiveRecord::Migration[5.1]
  def change
    remove_column :ayahs, :created_at, :string
    remove_column :ayahs, :updated_at, :string
  end
end
