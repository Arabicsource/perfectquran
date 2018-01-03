# frozen_string_literal: true

require 'rails_helper'

describe 'GET /accounts/subscriptions/show', type: :request do
  let(:url) { accounts_subscription_path }
  let(:account) { create :account }

  context 'when an account has a subscription and charge' do
    before do
      create :subscription, account: account
      create :charge, account: account
    end

    it_behaves_like 'an account get request'
  end

  context 'when account has no subscription' do
    before { login_as account }

    it 'redirects to new subscription path' do
      get url

      expect(response).to redirect_to new_accounts_subscription_path
    end
  end
end
