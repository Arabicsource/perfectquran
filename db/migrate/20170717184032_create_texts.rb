class CreateTexts < ActiveRecord::Migration[5.1]
  def change
    create_table :texts do |t|
      t.text :content
      t.references :quran, foreign_key: true
      t.references :ayah, foreign_key: true

      t.timestamps
    end
  end
end
