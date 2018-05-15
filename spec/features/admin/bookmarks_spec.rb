# frozen_string_literal: true

require 'rails_helper'

feature 'Delete Bookmark', js: true do
  let(:admin) { create :admin }
  let(:bookmark) { create :bookmark }

  scenario 'when successful' do
    bookmark
    login_as admin
    visit admin_bookmarks_path

    click_on bookmark.id
    click_on 'Delete'

    expect(page).to have_css '.notification', text: 'bookmark was deleted'
    expect(page).to_not have_text bookmark.id
    expect(current_path).to eq admin_bookmarks_path
  end
end
