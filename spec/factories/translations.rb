# frozen_string_literal: true

# == Schema Information
#
# Table name: translations
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  language_id :integer
#

FactoryBot.define do
  factory :translation, class: Quran::Translation do
    name 'string'
    description 'string'
    language
  end
end
