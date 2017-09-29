# frozen_string_literal: true

# == Schema Information
#
# Table name: ayahs
#
#  id               :integer          not null, primary key
#  number           :integer
#  character_length :integer
#  percent_of_total :float
#  percent_of_surah :float
#  surah_id         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  favorites_count  :integer          default(0)
#  memories_count   :integer          default(0)
#

FactoryGirl.define do
  factory :ayah do
    number 1
    character_length 1
    percent_of_total 0.1
    percent_of_surah 0.1
    surah

    trait :with_favorites do
      transient do
        number_of_favorites 3
      end

      after :create do |ayah, eval|
        FactoryGirl.create_list :favorite, eval.number_of_favorites, ayah: ayah
      end
    end

    trait :with_memories do
      transient do
        number_of_memories 3
      end

      after :create do |ayah, eval|
        FactoryGirl.create_list :memory, eval.number_of_memories, ayah: ayah
      end
    end
  end
end
