# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Edit a menu link' do
  scenario 'successfully' do
    menu = create :menu, name: 'menu123'
    create :menu_link, name: 'link123', menu: menu

    login_as create(:admin)

    visit admin_root_path
    click_on 'Menus'
    click_on 'menu123'
    within 'table' do
      click_on 'Edit'
    end

    fill_in 'Name', with: 'linkabc'
    fill_in 'Path', with: 'pathabc'
    click_on 'Save Menu link'

    expect(page)
      .to have_css '.notification',
                   text: 'The menu link linkabc was updated'

    within 'section#main' do
      expect(page).to have_content 'menu123'
      expect(page).to have_selector 'td', text: 'linkabc'
      expect(page).not_to have_selector 'td', text: 'link123'
      expect(page).to have_selector 'td', text: 'pathabc'
    end
  end
end
