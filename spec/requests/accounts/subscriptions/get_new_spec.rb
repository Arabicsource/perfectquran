# frozen_string_literal: true

require 'rails_helper'

describe 'GET /accounts/subscriptions/new', type: :request do
  let(:url) { new_accounts_subscription_path }

  context 'with guest' do
    before { get url }
    it { expect(response).to redirect_to new_account_session_path }
  end

  context 'with account' do
    before do
      login_as create :account
      get url
    end

    it { expect(response).to be_successful }
  end
end
