# frozen_string_literal: true

# :nodoc:
class PatronSubscriber
  def initialize(account, token, plan_id)
    @account = account
    @token = token
    @plan_id = plan_id
  end

  def run!
    create_external_customer
    create_external_subscription
    create_subscription
    create_charge
  rescue StandardError
    false
  end

  private

  attr_reader :external_subscription, :external_customer

  def create_external_customer
    @external_customer = Stripe::Customer.create(
      email: @account.email,
      source: @token
    )
  end

  def create_external_subscription
    @external_subscription = Stripe::Subscription.create(
      customer: customer_token,
      plan: @plan_id
    )
  end

  def create_subscription
    Subscription.create!(
      account: @account,
      customer_token: customer_token,
      subscription_token: subscription_token,
      status:  subscription_status,
      payment_brand: payment_brand,
      payment_last4: payment_last4,
      current_period_end: current_period_end
    )
  end

  def create_charge
    Charge.create!(
      account: @account,
      amount_in_cents: 500,
      payment_brand: payment_brand,
      payment_last4: payment_last4
    )
  end

  def customer_token
    external_customer.id
  end

  def subscription_token
    external_subscription.id
  end

  def subscription_status
    external_subscription.status
  end

  def payment_brand
    external_customer.sources.data.first.brand
  end

  def payment_last4
    external_customer.sources.data.first.last4
  end

  def current_period_end
    external_subscription.current_period_end
  end
end
