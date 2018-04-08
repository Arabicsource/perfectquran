class CreateMosques < ActiveRecord::Migration[5.2]
  def change
    create_table :mosques do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :zip_code
      t.string :website

      t.timestamps
    end
  end
end
