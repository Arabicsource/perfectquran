# frozen_string_literal: true

require 'rails_helper'

feature 'Browsing' do
  let(:account) { create :account }

  xscenario 'settings' do
    login_as account
    visit root_path

    find('a.settings').click
    expect(page).to have_title 'Settings'

    click_on 'Edit Profile'
    expect(page).to have_title 'Edit Profile'

    click_on 'Settings'
    click_on 'Email Preferences'
    expect(page).to have_title 'Email Preferences'

    click_on 'Settings'
    click_on 'Quran Preferences'
    expect(page).to have_title 'Quran Preferences'

    click_on 'Settings'
    expect(page).to have_title 'Settings'
  end
end
