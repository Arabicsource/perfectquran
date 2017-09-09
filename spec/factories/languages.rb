# frozen_string_literal: true

# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  name       :string
#  direction  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :language do
    name 'string'
    direction 'string'
  end
end
