# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id             :bigint(8)        not null, primary key
#  title          :string
#  content        :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  visibility     :integer          default("draft")
#  permalink      :string
#  collection     :integer          default("post")
#  category_id    :bigint(8)
#  account_id     :bigint(8)
#  comments_count :integer          default(0)
#

FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "title#{n}" }
    content 'content_string'
    visibility :published
    category
    account

    trait :as_draft do
      visibility :draft
    end

    trait :as_trash do
      visibility :draft
    end
  end

  factory :post, class: 'Article' do
    sequence(:title) { |n| "Post #{n}" }
    content 'Post content'
    visibility :published
    category
    account
  end
end
