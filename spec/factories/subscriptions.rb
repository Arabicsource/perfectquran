# frozen_string_literal: true

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
