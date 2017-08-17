# == Schema Information
#
# Table name: memories
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  ayah_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
    factory :memory do
      ayah
      user
    end
  end