# frozen_string_literal: true

require 'rails_helper'

describe 'GET Accounts::Profiles#show', type: :request do
  context 'guest' do
    it 'redirects the user to the login page' do
      get accounts_profile_path

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'basic account' do
    it 'responds successfully' do
      login_as create(:account)

      get accounts_profile_path

      expect(response).to be_successful
    end
  end
end
