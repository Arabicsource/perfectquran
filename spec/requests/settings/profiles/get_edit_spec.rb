# frozen_string_literal: true

require 'rails_helper'

describe 'GET Settings::Profiles#edit', type: :request do
  context 'guest' do
    it 'redirects the user to the login page' do
      get edit_settings_profile_path

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'basic account' do
    it 'responds successfully' do
      account = create :account
      create :profile, account: account
      login_as account

      get edit_settings_profile_path

      expect(response).to be_successful
    end
  end
end
