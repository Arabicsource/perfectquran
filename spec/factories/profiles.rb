# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  name       :string
#  username   :string
#  bio        :text
#  account_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :profile do
    username 'username'
  end
end
