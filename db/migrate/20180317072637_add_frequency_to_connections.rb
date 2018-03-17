class AddFrequencyToConnections < ActiveRecord::Migration[5.2]
  def change
    add_column :connections, :frequency, :integer
  end
end
