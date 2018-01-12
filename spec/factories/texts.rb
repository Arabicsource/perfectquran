# frozen_string_literal: true

# == Schema Information
#
# Table name: texts
#
#  id             :integer          not null, primary key
#  content        :text
#  translation_id :integer
#  ayah_id        :integer
#

FactoryBot.define do
  factory :text, class: Quran::Text do
    content 'string'
    translation
    ayah
  end
end
