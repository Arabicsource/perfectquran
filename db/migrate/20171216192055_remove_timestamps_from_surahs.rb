class RemoveTimestampsFromSurahs < ActiveRecord::Migration[5.1]
  def change
    remove_column :surahs, :created_at, :string
    remove_column :surahs, :updated_at, :string
  end
end
