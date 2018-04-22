# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  username   :string
#  bio        :text
#  account_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :profile do
    sequence(:username) { |n| "username_#{n}" }
  end
end
