# frozen_string_literal: true

require 'rails_helper'

describe 'Accounts::Connections#destroy', type: :request do
  let(:account) { create :account }
  let(:connection) { create :connection, account: account }
  let(:uri) { "/accounts/connections/#{connection.id}" }

  context 'without account' do
    it 'redirects to the login page' do
      delete uri

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'with account' do
    before { login_as account }

    context 'when successful' do
      it 'redirects' do
        delete uri

        expect(response).to redirect_to accounts_connections_path
      end

      it 'deletes connection' do
        connection

        expect { delete uri }.to change(Connection, :count).by(-1)
      end
    end
  end
end
