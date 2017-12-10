# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'View an article' do
  scenario 'successfully' do
    create :article, title: 'title123', content: 'content123'
    login_as create(:admin)
    visit admin_root_path

    click_on 'Articles'
    click_on 'title123'

    within 'section#main' do
      expect(page).to have_content 'title123'
      expect(page).to have_content 'content123'
    end
  end
end
