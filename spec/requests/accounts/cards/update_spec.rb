# frozen_string_literal: true

require 'rails_helper'

describe 'PATCH Accounts::Cards#update', type: :request do
  let(:account) { create :account }
  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:invalid_params) { { stripeToken: '' } }
  let(:uri) { accounts_card_path }

  let(:valid_params) do
    { stripeToken: stripe_helper.generate_card_token(last4: '4000') }
  end

  let(:customer) do
    Stripe::Customer.create(source: stripe_helper.generate_card_token)
  end

  context 'without account' do
    it 'redirects to the login page' do
      patch uri, params: valid_params

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'with account' do
    before do
      create :subscription, account: account, customer_token: customer.id
      login_as account
    end

    context 'when success' do
      it 'redirects' do
        patch uri, params: valid_params

        expect(response).to redirect_to accounts_subscription_path
      end

      it 'updates subscription' do
        patch uri, params: valid_params

        expect(account.reload.subscription.payment_last4).to eq '4000'
      end
    end

    context 'when failure' do
      it 'does not redirect' do
        patch uri, params: invalid_params

        expect(response).not_to redirect_to accounts_subscription_path
      end

      it 'does not update subscription' do
        patch uri, params: invalid_params

        expect(account.reload.subscription.payment_last4).to eq '4242'
      end
    end
  end
end
