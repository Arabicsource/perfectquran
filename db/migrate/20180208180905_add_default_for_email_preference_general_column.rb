class AddDefaultForEmailPreferenceGeneralColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :account_email_preferences, :general, :boolean, default: true
  end
end
