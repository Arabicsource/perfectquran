# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Publish an article' do
  scenario 'successfully' do
    create :article, title: 'title123', visibility: 'draft'
    login_as create(:admin)

    visit admin_root_path
    click_on 'Articles'
    click_on 'title123'
    click_on 'Edit'

    select 'Publish', from: 'Visibility'
    click_on 'Save Article'

    expect(page)
      .to have_css '.notification',
                   text: 'The article title123 was updated'

    within 'section#main' do
      expect(page).to have_selector 'td', text: 'publish'
    end
  end
end
