# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'View a category' do
  scenario 'successfully' do
    create :category, name: 'name123', description: 'description123'
    login_as create(:admin)
    visit admin_root_path

    click_on 'Categories'
    click_on 'name123'

    within 'section#main' do
      expect(page).to have_content 'name123'
      expect(page).to have_content 'description123'
    end
  end
end
