class AddLastAyahIdToConnections < ActiveRecord::Migration[5.1]
  def change
    add_column :connections, :last_ayah_id, :integer, default: 0
  end
end
