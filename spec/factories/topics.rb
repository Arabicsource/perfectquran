FactoryGirl.define do
  factory :topic do |topic|
    subject 'TopicSubject'
    content 'TopicContent'
    topic.discussable { |topic| topic.association(:ayah) }
    user
  end
end