class AddPermalinkToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :permalink, :string
    add_index :posts, :permalink, unique: true
  end
end
