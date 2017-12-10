# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers
include JavascriptHelper

feature 'Create a new static page', js: true do
  scenario 'successfully' do
    create :category, name: 'category123'
    login_as create(:admin)
    visit admin_root_path
    click_on 'New Article'

    fill_in 'Title', with: 'title123'
    fill_in_trix_editor 'content'
    select 'Draft', from: 'Visibility'
    select 'Page', from: 'Collection'
    select 'category123', from: 'Category'
    click_on 'Save Article'

    expect(page)
      .to have_css '.notification',
                   text: 'The article title123 was created'

    expect(page).to have_title 'Articles'

    within 'section#main' do
      expect(page).to have_content 'title123'
      expect(page).to have_content 'draft'
      expect(page).to have_content 'page'
      expect(page).to have_content 'category123'
    end
  end
end
