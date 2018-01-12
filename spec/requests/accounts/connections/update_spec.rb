# frozen_string_literal: true

require 'rails_helper'

describe 'Accounts::Connections#update', type: :request do
  let(:account) { create :account }
  let(:connection) { create :connection, account: account }
  let(:uri) { accounts_connection_path(connection) }
  let(:valid_params) { { connection: { active: true } } }
  let(:invalid_params) { { connection: { active: '' } } }

  context 'without account' do
    it 'redirects to the login page' do
      patch uri, params: valid_params

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'with account' do
    before { login_as account }

    context 'when success' do
      before { patch uri, params: valid_params }

      specify { expect(response).to redirect_to accounts_connections_path }
      specify { expect(connection.reload.active).to be_truthy }
    end

    context 'when failure' do
      before { patch uri, params: invalid_params }

      xspecify { expect(response).not_to redirect_to accounts_connections_path }
      specify { expect(connection.reload.active).to be_falsey }
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
