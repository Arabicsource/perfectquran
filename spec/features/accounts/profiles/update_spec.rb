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
      fill_in 'Username', with: 'username456'
      fill_in 'Bio', with: 'bio123'
      click_on 'Update Profile'
    end

    expect(current_path).to eq accounts_profile_path

    expect(page)
      .to have_css '.notification',
                   text: 'Alhamdulillah, Your profile was updated'

    expect(page).to have_text 'name123'
    expect(page).to have_text '@username456'
    expect(page).to have_text 'bio123'
  end
end
