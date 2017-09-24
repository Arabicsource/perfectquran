class AddPermalinkToPage < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :permalink, :string
    add_index :pages, :permalink, unique: true
  end
end
