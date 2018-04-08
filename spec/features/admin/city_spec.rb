# frozen_string_literal: true

require 'rails_helper'

feature 'New City', js: true do
  scenario 'when successful' do
    create :state, name: 'state123'
    login_as create :account, :as_admin
    visit admin_cities_path
    click_on 'New City'

    fill_in 'Name', with: 'city123'
    fill_in 'Code', with: 'CI'
    select 'state123', from: 'State'
    click_on 'Save City'

    expect(page).to have_css '.notification', text: /city was added/
    expect(page).to have_text 'city123'
  end
end
