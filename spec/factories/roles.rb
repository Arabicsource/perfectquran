FactoryGirl.define do
  factory :role do
    name 'member'

    trait :admin do
      name 'admin'
    end
  end
end