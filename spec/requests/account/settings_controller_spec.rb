# frozen_string_literal: true

require 'rails_helper'

describe 'Account::SettingsController', type: :request do
  let(:account) { create :account }

  describe 'GET account_settings_path' do
    context 'when not logged in' do
      before { get account_settings_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'when logged in' do
      before do
        login_as account
        get account_settings_path
      end

      specify { expect(response).to be_successful }
      specify { expect(response).to have_title 'Settings' }
    end
  end
end
