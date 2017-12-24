# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Edit profile settings' do
  scenario 'successfully' do
    account = create :account
    create :profile, account: account
    login_as account

    visit edit_accounts_profile_path

    within 'form#profile_form' do
      fill_in 'Name', with: 'name123'
      fill_in 'Username', with: 'username123'
      fill_in 'Bio', with: 'bio123'
      click_on 'Update Profile'
    end

    expect(page)
      .to have_css '.notification',
                   text: 'Alhamdulillah, Your profile was updated'
  end
end
