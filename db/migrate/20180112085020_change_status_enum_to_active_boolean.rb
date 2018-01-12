class ChangeStatusEnumToActiveBoolean < ActiveRecord::Migration[5.1]
  def change
    remove_column :connections, :status, :integer
    add_column :connections, :active, :boolean, default: false
  end
end
