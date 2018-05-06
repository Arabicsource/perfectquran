# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :bigint(8)        not null, primary key
#  content    :text
#  account_id :bigint(8)
#  article_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :comment do
    content 'content'
    account
    article
  end
end
