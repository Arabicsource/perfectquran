class CreateSurahs < ActiveRecord::Migration[5.1]
  def change
    create_table :surahs do |t|
      t.integer :number_of_ayahs
      t.integer :order_of_revelation
      t.integer :revelation_type
      t.string :permalink
      t.string :transliterated_name
      t.string :arabic_name
      t.string :english_name
      t.integer :character_length
      t.float :percent_of_total

      t.timestamps
    end
  end
end
