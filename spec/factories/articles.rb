# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "title#{n}" }
    content 'content_string'
    category
    account
  end
end
