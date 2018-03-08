class MemoryPolymorphic < ActiveRecord::Migration[5.2]
  def change
    rename_column :memories, :ayah_id, :memorable_id
    add_column :memories, :memorable_type, :string
  end
end
