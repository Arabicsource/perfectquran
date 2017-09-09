# frozen_string_literal: true

# == Schema Information
#
# Table name: rolings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  role_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :roling do
    user
    role
  end
end
