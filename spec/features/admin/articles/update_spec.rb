# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Edit an article' do
  scenario 'successfully' do
    create :article, title: 'title123'
    login_as create(:admin)

    visit admin_root_path
    click_on 'Articles'
    click_on 'title123'
    click_on 'Edit'

    fill_in 'Title', with: 'titleabc'
    click_on 'Save Article'

    expect(page)
      .to have_css '.notification',
                   text: 'The article titleabc was updated'

    within 'section#main' do
      expect(page).to have_selector 'td', text: 'titleabc'
      expect(page).not_to have_selector 'td', text: 'title123'
    end
  end
end
