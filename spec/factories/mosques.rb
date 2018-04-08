# frozen_string_literal: true

FactoryBot.define do
  factory :mosque do
    name 'Mosque'
    phone '111'
    email 'email'
    street 'street'
    zip_code '222'
    website 'website'
    city
  end
end
