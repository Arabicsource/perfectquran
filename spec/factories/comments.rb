# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  user_id          :integer
#  commentable_type :string
#  commentable_id   :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :comment do
    sequence(:content) { |n| "CommentContent-#{n}" }
    user
    association :commentable, factory: :post

    trait :with_flag do
      flag
    end
  end
end
