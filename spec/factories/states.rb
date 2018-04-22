# frozen_string_literal: true

# == Schema Information
#
# Table name: states
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  code       :string
#  country_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :state do
    name 'State'
    code 'ST'
    country
  end
end
