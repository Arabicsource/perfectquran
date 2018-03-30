# frozen_string_literal: true

FactoryBot.define do
  factory :memory do
    account
    ayah Ayah.first
  end
end
