# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string
#  content     :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  permalink   :string
#

FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "PostTitle#{n}" }
    sequence(:permalink) { |n| "posttitle#{n}" }
    content 'PostContent'
    category
    user

    trait :with_comments do
      transient do
        number_of_comments 3
      end

      after :create do |post, eval|
        FactoryBot.create_list(
          :comment, eval.number_of_comments, commentable: post
        )
      end
    end

    trait :with_flagged_comments do
      transient do
        number_of_comments 3
      end

      after :create do |post, eval|
        FactoryBot.create_list(
          :comment, eval.number_of_comments, :with_flag, commentable: post
        )
      end
    end

    trait :with_approved_comments do
      transient do
        number_of_comments 3
      end

      after :create do |post, eval|
        FactoryBot.create_list(
          :comment, eval.number_of_comments, :with_approval, commentable: post
        )
      end
    end

    trait :with_mixed_comments do
      transient do
        number_of_comments 3
      end

      after :create do |post, eval|
        FactoryBot.create_list(
          :comment, eval.number_of_comments, commentable: post
        )
        FactoryBot.create_list(
          :comment, eval.number_of_comments, :with_flag, commentable: post
        )
      end
    end
  end
end
