# frozen_string_literal: true

require 'rails_helper'

describe 'GET Settings::Accounts#edit', type: :request do
  context 'guest' do
    it 'redirects the user to the login page' do
      get edit_settings_account_path

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'member' do
    it 'responds successfully' do
      login_as create(:member)

      get edit_settings_account_path

      expect(response).to be_successful
    end
  end
end
