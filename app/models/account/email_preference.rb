# frozen_string_literal: true

# == Schema Information
#
# Table name: account_email_preferences
#
#  id         :integer          not null, primary key
#  account_id :integer
#  general    :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  daily_ayah :boolean          default(FALSE)
#

class Account
  # :nodoc:
  class EmailPreference < ApplicationRecord
    belongs_to :account
  end
end
