# frozen_string_literal: true

require 'rails_helper'

describe 'GET Accounts::Connections#callback', type: :request do
  let(:uri) { '/auth/twitter/callback' }
  let(:account) { create :account }
  let(:redirect_path) do
    '/auth/failure?message=invalid_credentials&strategy=twitter'
  end

  context 'without account' do
    it 'redirects to the login page' do
      get uri

      expect(response).to redirect_to new_account_session_path
    end

    it 'does not create a connection' do
      expect { get uri }.not_to change(Connection, :count)
    end
  end

  context 'with account' do
    before do
      login_as account
    end

    describe 'when successful' do
      it 'creates a connection' do
        expect { get uri }.to change(Connection, :count).by(1)
      end

      it 'redirects' do
        get uri

        expect(response).to(
          redirect_to(edit_account_connection_path(Connection.last))
        )
      end
    end

    context 'when connection exists' do
      let!(:connection) { create :connection, account: account, name: 'name' }

      it 'updates connection' do
        get uri

        expect(connection.reload.name).to eq 'nickname123'
      end

      it 'redirects' do
        get uri

        expect(response).to(
          redirect_to(edit_account_connection_path(connection))
        )
      end

      it 'does not create connection' do
        expect { get uri }.not_to change(Connection, :count)
      end
    end

    describe 'when failure' do
      before { OmniAuth.config.mock_auth[:twitter] = :invalid_credentials }

      it 'redirects' do
        get uri

        expect(response).to redirect_to redirect_path
      end

      it 'does not create a connection' do
        expect { get uri }.not_to change(Connection, :count)
      end
    end
  end
end
