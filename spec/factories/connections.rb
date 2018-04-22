# frozen_string_literal: true

# == Schema Information
#
# Table name: connections
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  provider       :string
#  provider_uid   :string
#  token          :string
#  secret         :string
#  account_id     :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  last_ayah_id   :integer          default(0)
#  active         :boolean          default(FALSE)
#  translation_id :bigint(8)
#  hashtags       :string
#  frequency      :integer
#  nickname       :string
#  image          :string
#  description    :string
#

FactoryBot.define do
  factory :connection do
    name 'name123'
    nickname 'nickname123'
    image 'image'
    description 'description'
    provider 'twitter'
    provider_uid 'uid12345'
    token 'tok12345'
    secret 'sec12345'
    last_ayah_id 0
    translation Quran::Translation.first
    account

    trait :as_hourly do
      sequence(:provider_uid) { |n| "hrly-#{n}" }
      frequency :hourly
    end

    trait :as_daily do
      sequence(:provider_uid) { |n| "dly-#{n}" }
      frequency :daily
    end
  end
end
