# frozen_string_literal: true

# == Schema Information
#
# Table name: mosques
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  phone      :string
#  email      :string
#  street     :string
#  city       :string
#  state      :string
#  country    :string
#  zip_code   :string
#  website    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city_id    :bigint(8)
#

FactoryBot.define do
  factory :mosque do
    name 'Mosque'
    phone '111'
    email 'mosque@perfectquran.co'
    street 'street'
    zip_code '222'
    website 'website'
    city
  end
end
