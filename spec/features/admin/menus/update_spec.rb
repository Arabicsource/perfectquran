# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Edit a menu' do
  scenario 'successfully' do
    create :menu, name: 'name123'
    login_as create(:admin)

    visit admin_root_path
    click_on 'Menus'
    click_on 'name123'
    click_on 'Edit'

    fill_in 'Name', with: 'nameabc'
    fill_in 'Description', with: 'description'
    click_on 'Save Menu'

    expect(page)
      .to have_css '.notification',
                   text: 'The menu nameabc was updated'

    within 'section#main' do
      expect(page).to have_selector 'td', text: 'nameabc'
      expect(page).not_to have_selector 'td', text: 'name123'
    end
  end
end
