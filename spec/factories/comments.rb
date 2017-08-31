FactoryGirl.define do
  factory :comment do
    content 'CommentContent'
    user
    topic
  end
end