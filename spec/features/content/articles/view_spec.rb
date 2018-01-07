# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'View an article' do
  scenario 'published' do
    article = create(
      :article,
      title: 'title123', content: 'content123', visibility: 'published'
    )

    visit content_article_path(article.permalink)

    expect(page).to have_content 'title123'
    expect(page).to have_content 'content123'
  end
end
