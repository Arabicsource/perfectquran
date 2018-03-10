# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PatronSubscriptionCanceler do
  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:plan) { stripe_helper.create_plan id: 'plan' }
  let(:token) { stripe_helper.generate_card_token }
  let(:account) { create :account }
  let(:customer) { Stripe::Customer.create(source: token) }

  let(:stripe_subscription) do
    Stripe::Subscription.create(customer: customer.id, plan: plan.id)
  end

  let!(:subscription) do
    create(
      :subscription,
      account: account,
      status: 'active',
      subscription_token: stripe_subscription.id
    )
  end

  context 'when successful' do
    it 'returns true' do
      expect(PatronSubscriptionCanceler.new(subscription).call).to be_truthy
    end

    it 'updates a subscription' do
      PatronSubscriptionCanceler.new(subscription).call

      expect(subscription.status).to eq 'cancelled'
    end
  end

  context 'when failure' do
    before do
      StripeMock.prepare_error(Stripe::StripeError, :retrieve_subscription)
    end

    it 'returns false' do
      expect(PatronSubscriptionCanceler.new(subscription).call).to be_falsey
    end

    it 'does not update subscription' do
      PatronSubscriptionCanceler.new(subscription).call

      expect(subscription.status).to eq 'active'
    end
  end
end
