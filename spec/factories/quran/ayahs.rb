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

FactoryBot.define do
  factory :ayah, class: Quran::Ayah do
    number 1
    character_length 1
    percent_of_total 0.1
    percent_of_surah 0.1
    surah
  end
end
