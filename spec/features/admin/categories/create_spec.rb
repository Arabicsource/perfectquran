# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Create a new static page' do
  scenario 'successfully' do
    login_as create(:admin)
    visit admin_root_path
    click_on 'Categories'
    click_on 'New Category'

    fill_in 'Name', with: 'name123'
    fill_in 'Description', with: 'description123'
    click_on 'Save Category'

    expect(page)
      .to have_css '.notification',
                   text: 'The category name123 was created'

    within 'section#main' do
      expect(page).to have_selector 'td', text: 'name123'
      expect(page).to have_selector 'td', text: 'description123'
    end
  end
end
