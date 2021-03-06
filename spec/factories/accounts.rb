# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id                     :bigint(8)        not null, primary key
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
#  role                   :string           default("validating")
#

FactoryBot.define do
  factory :account do
    sequence(:email) { |n| "eample#{n}@example.com" }
    password 'password'
    role 'validating'

    factory :admin_account do
      role 'admin'
    end

    factory :admin do
      confirmed_at Time.now
      role 'admin'
    end

    factory :member do
      confirmed_at Time.now
      role 'member'
    end

    factory :validating do
      confirmation_sent_at Time.now
      confirmation_token 'token'
    end

    trait :as_admin do
      confirmed_at Time.now
      role 'admin'
    end
  end
end
