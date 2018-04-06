# frozen_string_literal: true

require 'rails_helper'

describe 'Account::ConnectionsController', type: :request do
  let(:account) { create :account }

  describe 'GET account_connections_path' do
    context 'when not logged in' do
      before { get account_connections_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'when logged in' do
      before do
        login_as account
        get account_connections_path
      end

      specify { expect(response).to be_successful }
    end

    context 'when logged in on mobile' do
      before do
        login_as account
        mobile_browser
        get account_connections_path
      end

      specify { expect(response).to be_successful }
    end
  end
end
