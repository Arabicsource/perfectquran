# frozen_string_literal: true

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
#  bio                    :string
#  role                   :string           default("validating")
#

FactoryBot.define do
  factory :user do
    name 'FirstName LastName'
    sequence(:username) { |n| "username_#{n}" }
    sequence(:email) { |n| "eample#{n}@example.com" }
    password 'password'
    role 'validating'

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
  end
end
