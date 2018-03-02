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
  factory :ayah do
    sequence(:number) { |n| n }
    character_length 1
    surah
  end
end
