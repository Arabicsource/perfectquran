class DefaultForPageMemories < ActiveRecord::Migration[5.2]
  def change
    change_column_default :page_memories, :character_length, 0
  end
end
