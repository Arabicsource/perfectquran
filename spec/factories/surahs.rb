# frozen_string_literal: true

FactoryBot.define do
  factory :surah do
    number_of_ayahs 1
    order_of_revelation 1
    revelation_type 'meccan'
    permalink 'string'
    transliterated_name 'transliterated'
    arabic_name 'string'
    english_name 'string'
    character_length 1

    trait :with_ayahs do
      number_of_ayahs 3
      after(:create) do |surah|
        create_list :ayah, 3, surah: surah
      end
    end
  end
end
