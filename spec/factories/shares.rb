# frozen_string_literal: true

# == Schema Information
#
# Table name: shares
#
#  id         :integer          not null, primary key
#  ayah_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :share do
  end
end
