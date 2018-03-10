# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    sequence(:email) { |n| "eample#{n}@example.com" }
    password 'password'
    role 'validating'

    factory :admin_account do
      role 'admin'
    end

    factory :admin do
      confirmed_at Time.now
      role 'admin'
    end

    factory :member do
      confirmed_at Time.now
      role 'member'
    end

    factory :validating do
      confirmation_sent_at Time.now
      confirmation_token 'token'
    end

    trait :as_admin do
      confirmed_at Time.now
      role 'admin'
    end

    trait :with_subscription do
      after(:create) do |account|
        create :subscription, account: account
      end
    end
  end
end
