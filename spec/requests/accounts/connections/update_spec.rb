# frozen_string_literal: true

require 'rails_helper'

describe 'Accounts::Connections#update', type: :request do
  let(:account) { create :account }
  let(:connection) { create :connection, account: account }
  let(:uri) { accounts_connection_path(connection) }
  let(:valid_params) { { connection: { status: 'active' } } }
  let(:invalid_params) { { connection: { status: '' } } }

  context 'without account' do
    it 'redirects to the login page' do
      patch uri, params: valid_params

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'with account' do
    before { login_as account }

    context 'when success' do
      it 'redirects' do
        patch uri, params: valid_params

        expect(response).to redirect_to accounts_connections_path
      end

      it 'updates' do
        patch uri, params: valid_params

        expect(connection.reload.status).to eq 'active'
      end
    end

    context 'when failure' do
      it 'does not redirect' do
        patch uri, params: invalid_params

        expect(response).not_to redirect_to accounts_connections_path
      end

      it 'does not update' do
        patch uri, params: invalid_params

        expect(connection.reload.status).to eq 'inactive'
      end
    end
  end

  context 'when account is not the resource owner' do
    before { login_as create :account }

    it 'raises an exception' do
      expect { patch uri, params: valid_params }.to(
        raise_error(ActiveRecord::RecordNotFound)
      )
    end
  end
end
