# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Commenting' do
  scenario 'successfully' do
    article = create :article, visibility: 'published'
    login_as create :member
    visit content_article_path(article.permalink)

    fill_in 'Content', with: 'comment123'
    click_on 'Create Comment'

    expect(page).to have_css '.notification',
                             text: 'Alhamdulillah, your comment was created'
    expect(page).to have_text 'comment123'
  end
end
