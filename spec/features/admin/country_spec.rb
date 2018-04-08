# frozen_string_literal: true

require 'rails_helper'

feature 'New Country', js: true do
  scenario 'when successful' do
    login_as create :account, :as_admin
    visit admin_countries_path
    click_on 'New Country'

    fill_in 'Name', with: 'country123'
    fill_in 'Code', with: 'CO'
    click_on 'Save Country'

    expect(page).to have_css '.notification', text: /country was added/
    expect(page).to have_text 'country123'
  end
end
