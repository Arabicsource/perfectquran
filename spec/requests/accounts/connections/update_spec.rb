# frozen_string_literal: true

require 'rails_helper'

describe 'Accounts::Connections#update', type: :request do
  let(:uthmani) { create :translation, id: 1 }
  let(:account) { create :account }
  let(:connection) { create :connection, account: account }
  let(:uri) { accounts_connection_path(connection) }
  let(:invalid_params) { { connection: { active: '', translation_id: '' } } }

  let(:valid_params) do
    { connection: { active: true, translation_id: uthmani.id } }
  end

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
      specify { expect(connection.reload.translation).to eq uthmani }
    end

    context 'when failure' do
      before { patch uri, params: invalid_params }

      specify { expect(response).not_to redirect_to accounts_connections_path }
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
