class AddNicknameImageDescriptionToConnections < ActiveRecord::Migration[5.2]
  def change
    add_column :connections, :nickname, :string
    add_column :connections, :image, :string
    add_column :connections, :description, :string
  end
end
