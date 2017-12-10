# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Create a new menu link' do
  scenario 'successfully' do
    create :menu, name: 'menu123'
    login_as create(:admin)
    visit admin_root_path
    click_on 'Menus'
    click_on 'menu123'
    click_on 'New Link'

    fill_in 'Name', with: 'name123'
    fill_in 'Path', with: '/link/path'
    click_on 'Save Menu link'

    expect(page)
      .to have_css '.notification',
                   text: 'The link name123 was created'

    within 'section#main' do
      expect(page).to have_content 'menu123'
      expect(page).to have_selector 'td', text: 'name123'
      expect(page).to have_selector 'td', text: '/link/path'
    end
  end
end
