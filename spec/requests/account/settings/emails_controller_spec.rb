# frozen_string_literal: true

require 'rails_helper'

describe Account::Settings::EmailsController, type: :request do
  let(:account) { create :account }

  describe 'GET edit_account_settings_email_path' do
    context 'when not logged in' do
      before { get edit_account_settings_email_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'when logged in' do
      before do
        login_as account
        get edit_account_settings_email_path
      end

      specify { expect(response).to be_successful }
      specify { expect(response).to have_title 'Edit Email Preferences' }
    end
  end
end
