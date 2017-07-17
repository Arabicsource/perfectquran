class CreateAyahs < ActiveRecord::Migration[5.1]
  def change
    create_table :ayahs do |t|
      t.integer :number
      t.integer :character_length
      t.float :percent_of_total
      t.float :percent_of_surah
      t.references :surah, foreign_key: true

      t.timestamps
    end
  end
end
