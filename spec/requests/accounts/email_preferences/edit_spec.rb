# frozen_string_literal: true

require 'rails_helper'

describe '/account/email_preferences/edit', type: :request do
  let(:url) { edit_account_email_preferences_path }
  let(:account) { create :account }
  let(:title) { 'Edit Email Preferences' }

  it_behaves_like 'an account get request'
end
