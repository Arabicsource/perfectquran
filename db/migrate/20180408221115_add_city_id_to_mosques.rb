class AddCityIdToMosques < ActiveRecord::Migration[5.2]
  def change
    add_reference :mosques, :city, foreign_key: true
  end
end
