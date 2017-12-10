# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Create a new menu' do
  scenario 'successfully' do
    login_as create(:admin)
    visit admin_root_path
    click_on 'Menus'
    click_on 'New Menu'

    fill_in 'Name', with: 'name123'
    fill_in 'Description', with: 'description123'
    click_on 'Save Menu'

    expect(page)
      .to have_css '.notification',
                   text: 'The menu name123 was created'

    within 'section#main' do
      expect(page).to have_selector 'td', text: 'name123'
      expect(page).to have_selector 'td', text: 'description123'
    end
  end
end
