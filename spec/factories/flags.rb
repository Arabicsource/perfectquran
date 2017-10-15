FactoryGirl.define do
  factory :flag do
    comment
    ip_address '127.0.0.1'
    content 'Reason Flagged'
  end
end
