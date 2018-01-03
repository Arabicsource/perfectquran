# frozen_string_literal: true

# == Schema Information
#
# Table name: subscriptions
#
#  id                 :integer          not null, primary key
#  account_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  customer_token     :string
#  subscription_token :string
#  status             :string
#  payment_brand      :string
#  payment_last4      :string
#  current_period_end :string
#

FactoryBot.define do
  factory :subscription do
    customer_token 'cus_token'
    subscription_token 'sub_token'
    status 'active'
    payment_brand 'Visa'
    payment_last4 '4242'
    current_period_end '1111'
  end
end
