class RemoveMemoryPolymorphism < ActiveRecord::Migration[5.2]
  def change
    rename_column :memories, :memorable_id, :ayah_id
    remove_column :memories, :memorable_type
  end
end
