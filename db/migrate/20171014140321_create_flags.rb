class CreateFlags < ActiveRecord::Migration[5.1]
  def change
    create_table :flags do |t|
      t.references :user, foreign_key: true
      t.references :comment, foreign_key: true
      t.string :ip_address
      t.text :content

      t.timestamps
    end
  end
end
