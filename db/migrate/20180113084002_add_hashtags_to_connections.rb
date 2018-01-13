class AddHashtagsToConnections < ActiveRecord::Migration[5.1]
  def change
    add_column :connections, :hashtags, :string
  end
end
