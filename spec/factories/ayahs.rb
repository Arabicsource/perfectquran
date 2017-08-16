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

      after :create do |ayah, evaluator|
        FactoryGirl.create_list :favorite, evaluator.number_of_favorites, ayah: ayah
      end
    end
  end
end
