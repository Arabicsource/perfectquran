class CreateConnections < ActiveRecord::Migration[5.1]
  def change
    create_table :connections do |t|
      t.string :name
      t.string :provider
      t.string :provider_uid
      t.string :token
      t.string :secret
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
