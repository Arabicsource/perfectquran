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

require 'rails_helper'

RSpec.describe Account::EmailPreference, type: :model do
  it { is_expected.to belong_to :account }
end
