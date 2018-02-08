# == Schema Information
#
# Table name: account_email_preferences
#
#  id         :integer          not null, primary key
#  account_id :integer
#  general    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Account::EmailPreference < ApplicationRecord
  belongs_to :account
end
