# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id             :integer          not null, primary key
#  title          :string
#  content        :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  visibility     :integer          default("draft")
#  permalink      :string
#  collection     :integer          default("post")
#  category_id    :integer
#  account_id     :integer
#  comments_count :integer          default(0)
#

FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "title#{n}" }
    content 'content_string'
    category
    account
  end
end
