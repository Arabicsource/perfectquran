# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "title#{n}" }
    content 'content_string'
    visibility :published
    category
    account

    trait :as_draft do
      visibility :draft
    end

    trait :as_trash do
      visibility :draft
    end
  end
end
