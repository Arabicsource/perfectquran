# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentMethodUpdater do
  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:token) { stripe_helper.generate_card_token(last4: '4000') }
  let(:account) { create :account }

  let(:customer) do
    Stripe::Customer.create(source: stripe_helper.generate_card_token)
  end

  let(:subscription) do
    create :subscription, account: account, customer_token: customer.id
  end

  context 'when successful' do
    it 'updates a subscription' do
      expect { PaymentMethodUpdater.new(subscription, token).call }.to(
        change(subscription.reload, :payment_last4)
      )
    end
  end

  context 'when failure' do
    before { StripeMock.prepare_error(Stripe::StripeError, :get_customer) }

    it 'returns false' do
      expect(PaymentMethodUpdater.new(subscription, token).call).to be_falsey
    end

    it 'does not update subscription' do
      expect { PaymentMethodUpdater.new(subscription, token).call }.not_to(
        change(subscription.reload, :payment_last4)
      )
    end
  end
end
