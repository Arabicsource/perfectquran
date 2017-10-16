class AddApprovedToFlags < ActiveRecord::Migration[5.1]
  def change
    add_column :flags, :approved, :boolean, default: false
  end
end
