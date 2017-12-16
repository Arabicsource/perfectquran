class RemoveTimestampsFromLanguages < ActiveRecord::Migration[5.1]
  def change
    remove_column :languages, :created_at, :string
    remove_column :languages, :updated_at, :string
  end
end
