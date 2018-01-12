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
