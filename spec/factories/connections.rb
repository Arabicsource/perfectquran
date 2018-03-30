# frozen_string_literal: true

FactoryBot.define do
  factory :connection do
    name 'nickname123'
    provider 'twitter'
    sequence(:provider_uid) { |n| "uid#{n}" }
    token 'tok12345'
    secret 'sec12345'
    last_ayah_id 0
    translation Translation.first
    account
  end
end
