class RemovePagesTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :pages if ActiveRecord::Base.connection.table_exists?  'pages'
  end
end
