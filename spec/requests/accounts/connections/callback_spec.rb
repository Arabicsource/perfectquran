# frozen_string_literal: true

require 'rails_helper'

describe 'GET Accounts::Connections#callback', type: :request do
  before(:all) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.logger = Logger.new('/dev/null')
    OmniAuth.config.add_mock(
      :twitter,
      uid: '12345',
      info: { nickname: 'example' },
      credentials:
        {
          token: '6789',
          secret: 'abcdef'
        }
    )
  end

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

  context 'basic account' do
    before do
      login_as account
    end

    describe 'when successful' do
      it 'creates a connection' do
        expect { get uri }.to change(Connection, :count).by(1)
      end

      it 'redirects' do
        get uri

        expect(response).to redirect_to accounts_connections_path
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
