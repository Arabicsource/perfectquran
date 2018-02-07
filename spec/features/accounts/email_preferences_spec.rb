# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Email Preferences' do
  let(:account) { create :account }

  background { login_as account }

  scenario 'for account' do
    visit accounts_root_path

    click_on 'accounts-navbar-settings-link'
    click_on 'Email Preferences'

    pending

    expect(page).to have_field('email-preferences-general', checked: true)
  end
end
