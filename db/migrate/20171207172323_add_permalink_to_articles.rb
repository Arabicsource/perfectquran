class AddPermalinkToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :permalink, :string
  end
end
