# frozen_string_literal: true

class PaymentMethodUpdater
  def initialize(subscription, token)
    @subscription = subscription
    @token = token
  end

  def call
    update_external_customer
    update_subscription
  rescue StandardError
    false
  end

  private

  attr_reader :external_customer

  def update_external_customer
    @external_customer = Stripe::Customer.retrieve(@subscription.customer_token)
    @external_customer.source = @token
    @external_customer.save
  end

  def update_subscription
    @subscription.update_attributes!(
      payment_brand: payment_brand,
      payment_last4: payment_last4
    )
  end

  def payment_brand
    external_customer.sources.data.first.brand
  end

  def payment_last4
    external_customer.sources.data.first.last4
  end
end
