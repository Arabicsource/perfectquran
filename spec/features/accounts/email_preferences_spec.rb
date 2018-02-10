# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Email Preferences' do
  let(:account) { create :account }

  background do
    login_as account
    visit account_root_path

    click_on 'accounts-navbar-settings-link'
    click_on 'Email Preferences'
  end

  scenario 'for newly created account' do
    expect(page).to have_field('account_email_preference_general', checked: true)
  end

  scenario 'when account unsubscribes from general' do
    page.find('#account_email_preference_general').set(false)
    click_on 'Save Email Preferences'

    expect(page).to have_css '.notification', text: 'Your email preferences have been updated'
  end
end
