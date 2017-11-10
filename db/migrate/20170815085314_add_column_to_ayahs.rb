class AddColumnToAyahs < ActiveRecord::Migration[5.1]
  def change
    add_column :ayahs, :favorites_count, :integer, default: 0

    Quran::Ayah.all.each { |a| Quran::Ayah.reset_counters(a.id, :favorites) }
  end
end
