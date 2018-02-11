class CreateQuranDailyAyahs < ActiveRecord::Migration[5.2]
  def change
    create_table :quran_daily_ayahs do |t|
      t.references :quran_ayah, foreign_key: true

      t.timestamps
    end
  end
end
