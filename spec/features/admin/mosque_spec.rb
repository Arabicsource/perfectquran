# frozen_string_literal: true

require 'rails_helper'

feature 'New Mosque', js: true do
  scenario 'when successful' do
    create :city, name: 'city123'
    login_as create :account, :as_admin
    visit admin_root_path
    click_on 'Mosques'
    click_on 'New Mosque'

    fill_in 'Name', with: 'name123'
    fill_in 'Phone',	with: "1111111111"
    fill_in 'Email',	with: 'info@mosqueemail.com'
    fill_in 'Street', with: '123 Main St.'
    select 'city123', from: 'Location'
    fill_in 'Zip Code', with: '12345'
    fill_in 'Website', with: 'mosquewebsite.com'
    click_on 'Save Mosque'

    expect(page).to have_css '.notification', text: /mosque was added/
    expect(page).to have_text 'name123'
  end
end
