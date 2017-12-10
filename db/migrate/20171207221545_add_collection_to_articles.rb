class AddCollectionToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :collection, :integer, default: 0
  end
end
