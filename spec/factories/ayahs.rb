# frozen_string_literal: true

FactoryBot.define do
  factory :ayah do
    sequence(:number) { |n| n }
    character_length 1
    surah
    page_id 1
    juz_id 1
  end
end
