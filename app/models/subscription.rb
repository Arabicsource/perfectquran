# frozen_string_literal: true

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
