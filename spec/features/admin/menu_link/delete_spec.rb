# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Delete a menu link' do
  scenario 'through delete button' do
    menu = create :menu, name: 'menu123'
    create :menu_link, menu: menu, name: 'link123'
    login_as create(:admin)

    visit admin_root_path
    click_on 'Menus'
    click_on 'menu123'
    within 'table' do
      click_on 'Delete'
    end

    expect(page)
      .to have_css '.notification',
                   text: 'The menu link link123 was deleted'

    within 'section#main' do
      expect(page).not_to have_selector 'td', text: 'link123'
    end
  end
end
