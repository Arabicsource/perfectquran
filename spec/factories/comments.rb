FactoryGirl.define do
  factory :comment do
    content 'CommentContent'
    user
  end
end