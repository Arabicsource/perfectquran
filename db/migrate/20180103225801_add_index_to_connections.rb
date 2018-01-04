class AddIndexToConnections < ActiveRecord::Migration[5.1]
  def change
    add_index :connections, [:provider_uid, :provider], unique: true
  end
end
