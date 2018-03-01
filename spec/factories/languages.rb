# frozen_string_literal: true

# == Schema Information
#
# Table name: languages
#
#  id        :integer          not null, primary key
#  name      :string
#  direction :string
#

FactoryBot.define do
  factory :language do
    name 'string'
    direction 'string'
  end
end
