# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  username               :string
#

FactoryGirl.define do

  factory :user do
    name 'FirstName LastName'
    sequence(:username) { |n| "username_#{n}" }
    sequence(:email) {|n| "eample#{n}@example.com" }
    password 'password'

    trait :confirmed do
      confirmed_at Time.now
    end

    trait :admin do
      after(:create) do |user|
        user.roles << create(:role, :admin)
      end
    end
  end
end
