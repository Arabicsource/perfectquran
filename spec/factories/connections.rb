# frozen_string_literal: true

# == Schema Information
#
# Table name: connections
#
#  id           :integer          not null, primary key
#  name         :string
#  provider     :string
#  provider_uid :string
#  token        :string
#  secret       :string
#  account_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryBot.define do
  factory :connection do
    name 'nickname123'
    provider 'twitter'
    provider_uid 'uid12345'
    token 'tok12345'
    secret 'sec12345'
  end
end
