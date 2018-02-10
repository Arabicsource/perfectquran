class AddDailyAyahToEmailPreference < ActiveRecord::Migration[5.2]
  def change
    add_column :account_email_preferences, :daily_ayah, :boolean, default: false
  end
end
