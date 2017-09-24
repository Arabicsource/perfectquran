# frozen_string_literal: true

# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  permalink  :string
#

FactoryGirl.define do
  factory :page do
    sequence(:title) { |n| "PageTitle#{n}" }
    sequence(:permalink) { |n| "pagetitle#{n}" }
    content 'PageContent'
    user
  end
end
