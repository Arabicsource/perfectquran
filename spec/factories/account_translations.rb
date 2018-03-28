# frozen_string_literal: true

FactoryBot.define do
  factory :account_translation do
    account
    primary true
  end
end
