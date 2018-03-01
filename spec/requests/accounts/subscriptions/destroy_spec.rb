# frozen_string_literal: true

require 'rails_helper'

describe 'DELETE /account/subscriptions/destroy', type: :request do
  let(:uri) { account_subscription_path }
  let(:account) { create :account }

  context 'without account' do
    it 'redirects to login' do
      delete uri

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'with account' do
    before { login_as account }

    context 'without subscription' do
      it 'redirects' do
        delete uri

        expect(response).to redirect_to edit_account_profile_path
      end
    end

    context 'with cancelled subscription' do
      before { create :subscription, account: account, status: 'cancelled' }

      it 'redirects' do
        delete uri

        expect(response).to redirect_to account_subscription_path
      end
    end

    context 'with active subscription' do
      let(:plan) { stripe_helper.create_plan(id: '1') }
      let(:stripe_helper) { StripeMock.create_test_helper }
      let(:token) { stripe_helper.generate_card_token }

      before { PatronSubscriber.new(account, token, plan.id).run! }

      it 'redirects' do
        delete uri

        expect(response).to redirect_to account_subscription_path
      end

      it 'updates subscription' do
        delete uri

        expect(account.reload.subscription.status).to eq 'cancelled'
      end
    end
  end
end
