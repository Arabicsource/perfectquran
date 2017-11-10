class AddMemoriesCountToAyahs < ActiveRecord::Migration[5.1]
  def change
    add_column :ayahs, :memories_count, :integer, default: 0
    Quran::Ayah.all.each { |a| Quran::Ayah.reset_counters(a.id, :memories) }
  end
end
