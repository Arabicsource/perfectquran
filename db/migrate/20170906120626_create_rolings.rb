class CreateRolings < ActiveRecord::Migration[5.1]
  def change
    create_table :rolings do |t|
      t.references :user, foreign_key: true
      t.references :role, foreign_key: true

      t.timestamps
    end
  end
end
