# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Edit account settings' do
  scenario 'successfully' do
    member = create :member
    login_as member

    visit edit_settings_account_path(member)

    within 'form#account_settings' do
      fill_in 'Name', with: 'name123'
      fill_in 'Username', with: 'username123'
      fill_in 'Bio', with: 'bio123'
      click_on 'Update Account Settings'
    end

    expect(page)
      .to have_css '.notification',
                   text: 'Alhamdulillah, Your account settings were updated'

    expect(page).to have_text 'name123'
  end
end
