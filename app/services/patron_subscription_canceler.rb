# frozen_string_literal: true

class PatronSubscriptionCanceler
  def initialize(subscription)
    @subscription = subscription
    @token = subscription.subscription_token
  end

  def call
    cancel_external_subscription
    cancel_subscription
  rescue StandardError
    false
  end

  private

  def cancel_external_subscription
    Stripe::Subscription.retrieve(@token)
                        .delete(at_period_end: true)
  end

  def cancel_subscription
    @subscription.update_attribute(:status, 'cancelled')
  end
end
