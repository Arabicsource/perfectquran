class RemoveTimestampsFromTexts < ActiveRecord::Migration[5.1]
  def change
    remove_column :texts, :created_at, :string
    remove_column :texts, :updated_at, :string
  end
end
