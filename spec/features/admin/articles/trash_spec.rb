# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Trash an article' do
  scenario 'through edit form' do
    create :article, title: 'title123'
    login_as create(:admin)

    visit admin_root_path
    click_on 'Articles'
    click_on 'title123'
    click_on 'Edit'

    select 'Trash', from: 'Visibility'
    click_on 'Save Article'

    expect(page)
      .to have_css '.notification',
                   text: 'The article title123 was updated'

    within 'section#main' do
      expect(page).to have_selector 'td', text: 'trash'
    end
  end

  scenario 'through delete button' do
    create :article, title: 'title123'
    login_as create(:admin)

    visit admin_root_path
    click_on 'Articles'
    click_on 'title123'
    click_on 'Delete'

    expect(page)
      .to have_css '.notification',
                   text: 'The article title123 was deleted'

    within 'section#main' do
      expect(page).to have_selector 'td', text: 'trash'
    end
  end
end
