class AddMemoriesCountToAyahs < ActiveRecord::Migration[5.1]
  def change
    add_column :ayahs, :memories_count, :integer, default: 0
    Ayah.all.each { |a| Ayah.reset_counters(a.id, :memories) }
  end
end
