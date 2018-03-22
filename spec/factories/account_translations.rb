# frozen_string_literal: true

FactoryBot.define do
  factory :account_translation do
    translation
    account
    primary true
  end
end
