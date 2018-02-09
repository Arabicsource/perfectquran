# == Schema Information
#
# Table name: account_email_preferences
#
#  id         :integer          not null, primary key
#  account_id :integer
#  general    :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Account::EmailPreference, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
