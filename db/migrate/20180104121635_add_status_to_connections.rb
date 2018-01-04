class AddStatusToConnections < ActiveRecord::Migration[5.1]
  def change
    add_column :connections, :status, :integer
  end
end
