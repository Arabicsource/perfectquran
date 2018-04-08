# frozen_string_literal: true

require 'rails_helper'

feature 'New State', js: true do
  scenario 'when successful' do
    create :country, name: 'country123'
    login_as create :account, :as_admin
    visit admin_states_path
    click_on 'New State'

    fill_in 'Name', with: 'state123'
    fill_in 'Code', with: 'ST'
    select 'country123', from: 'Country'
    click_on 'Save State'

    expect(page).to have_css '.notification', text: /state was added/
    expect(page).to have_text 'state123'
  end
end
