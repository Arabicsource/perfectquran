# frozen_string_literal: true

require 'rails_helper'

describe 'GET Settings::Profiles#edit', type: :request do
  context 'guest' do
    it 'redirects the user to the login page' do
      get edit_accounts_profile_path

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'basic account' do
    it 'responds successfully' do
      account = create :account
      create :profile, account: account
      login_as account

      get edit_accounts_profile_path

      expect(response).to be_successful
    end

    context 'account without an associated profile' do
      it 'creates a profile for the account' do
        login_as create :account

        expect { get edit_accounts_profile_path }.to(
          change(Profile, :count).by(1)
        )
      end
    end
  end
end
