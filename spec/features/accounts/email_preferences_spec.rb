# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Email Preferences' do
  let(:account) { create :account }

  background { login_as account }

  scenario 'for newly created account' do
    visit account_root_path

    click_on 'accounts-navbar-settings-link'
    click_on 'Email Preferences'

    expect(page).to have_field('account_email_preference_general', checked: true)
  end
end
