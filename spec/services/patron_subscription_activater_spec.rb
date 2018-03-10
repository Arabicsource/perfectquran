# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PatronSubscriptionActivater do
  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:plan) { stripe_helper.create_plan id: 1 }
  let(:token) { stripe_helper.generate_card_token }
  let(:account) { create :account }
  let(:customer) { Stripe::Customer.create(source: token) }

  let(:stripe_subscription) do
    Stripe::Subscription.create(customer: customer.id, plan: plan.id)
                        .delete(at_period_end: true)
  end

  let!(:subscription) do
    create(
      :subscription,
      account: account,
      status: 'cancelled',
      subscription_token: stripe_subscription.id
    )
  end

  context 'when successful' do
    it 'returns true' do
      expect(PatronSubscriptionActivater.new(subscription).call).to be_truthy
    end

    it 'updates a subscription' do
      PatronSubscriptionActivater.new(subscription).call

      expect(subscription.status).to eq 'active'
    end
  end

  context 'when failure' do
    before do
      StripeMock.prepare_error(Stripe::StripeError, :retrieve_subscription)
    end

    it 'returns false' do
      expect(PatronSubscriptionActivater.new(subscription).call).to be_falsey
    end

    it 'does not update subscription' do
      PatronSubscriptionActivater.new(subscription).call

      expect(subscription.status).to eq 'cancelled'
    end
  end
end
