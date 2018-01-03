# frozen_string_literal: true

# :nodoc:
class PatronSubscriptionActivater
  def initialize(subscription)
    @subscription = subscription
    @token = subscription.subscription_token
  end

  def run!
    activate_external_subscription
    activate_subscription
  rescue
    false
  end

  private

  def activate_external_subscription
    subscription = Stripe::Subscription.retrieve(@token)
    item_id = subscription.items.data.first.id
    items = [{ id: item_id, plan: 1 }]
    subscription.items = items
    subscription.save
  end

  def activate_subscription
    @subscription.update_attribute(:status, 'active')
  end
end
