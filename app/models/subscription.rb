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

# :nodoc:
class Subscription < ApplicationRecord
  belongs_to :account

  validates :customer_token, presence: true
  validates :subscription_token, presence: true
  validates :status, presence: true
  validates :payment_brand, presence: true
  validates :payment_last4, presence: true
  validates :current_period_end, presence: true

  def active?
    status == 'active'
  end

  def cancelled?
    status == 'cancelled'
  end
end
