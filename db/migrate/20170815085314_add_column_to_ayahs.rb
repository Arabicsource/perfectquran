class AddColumnToAyahs < ActiveRecord::Migration[5.1]
  def change
    add_column :ayahs, :favorites_count, :integer, default: 0

    Ayah.all.each { |a| Ayah.reset_counters(a.id, :favorites) }
  end
end
