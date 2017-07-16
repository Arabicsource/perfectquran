# == Schema Information
#
# Table name: surahs
#
#  id                  :integer          not null, primary key
#  number_of_ayahs     :integer
#  order_of_revelation :integer
#  revelation_type     :integer
#  permalink           :string
#  transliterated_name :string
#  arabic_name         :string
#  english_name        :string
#  character_length    :integer
#  percent_of_total    :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryGirl.define do
  factory :surah do
    number_of_ayahs 1
    order_of_revelation 1
    character_length 1
    percent_of_total 0.1
    revelation_type :meccan
    transliterated_name 'string'
    arabic_name "string"
    english_name "string"
    permalink "string"
  end
end
