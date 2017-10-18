# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  permalink  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category Name #{n}" }

    trait :with_posts do
      transient do
        number_of_posts 3
      end

      after :create do |category, eval|
        FactoryGirl.create_list :post, eval.number_of_posts, category: category
      end
    end
  end
end
