# frozen_string_literal: true

# == Schema Information
#
# Table name: account_translations
#
#  id             :bigint(8)        not null, primary key
#  account_id     :bigint(8)
#  translation_id :bigint(8)
#  order          :integer          default(0)
#  primary        :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :account_translation do
    account
    primary true
  end
end
