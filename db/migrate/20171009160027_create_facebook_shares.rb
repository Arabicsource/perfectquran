class CreateFacebookShares < ActiveRecord::Migration[5.1]
  def change
    create_table :facebook_shares do |t|
      t.references :ayah, foreign_key: true

      t.timestamps
    end
  end
end
