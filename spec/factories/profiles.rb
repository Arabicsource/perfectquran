# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    sequence(:username) { |n| "username_#{n}" }
  end
end
