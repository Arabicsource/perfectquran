# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Delete a menu' do
  scenario 'through delete button' do
    create :menu, name: 'name123'
    login_as create(:admin)

    visit admin_root_path
    click_on 'Menus'
    click_on 'name123'
    click_on 'Delete'

    expect(page)
      .to have_css '.notification',
                   text: 'The menu name123 was deleted'

    within 'section#main' do
      expect(page).not_to have_selector 'td', text: 'name123'
    end
  end
end
