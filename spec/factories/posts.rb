# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "PostTitle#{n}" }
    content 'PostContent'
    category
    user
  end
end
