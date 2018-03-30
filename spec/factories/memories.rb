# frozen_string_literal: true

FactoryBot.define do
  factory :memory do
    account
    ayah Quran::Ayah.first
  end
end
