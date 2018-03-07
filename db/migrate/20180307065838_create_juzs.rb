class CreateJuzs < ActiveRecord::Migration[5.2]
  def change
    create_table :juzs do |t|
      t.integer :character_length
    end
  end
end
