# frozen_string_literal: true

FactoryBot.define do
  factory :translation do
    name 'translation_name'
    description 'translation_description'
    language
  end
end
