# frozen_string_literal: true

# == Schema Information
#
# Table name: topics
#
#  id               :integer          not null, primary key
#  subject          :string
#  content          :text
#  discussable_type :string
#  discussable_id   :integer
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :topic do |topic|
    subject 'TopicSubject'
    content 'TopicContent'
    topic.discussable { |t| t.association(:ayah) }
    user
  end
end
