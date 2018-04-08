# frozen_string_literal: true

FactoryBot.define do
  factory :connection do
    name 'nickname123'
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
