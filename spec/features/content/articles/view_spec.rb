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

feature 'View articles index' do
  scenario 'successfully' do
    create(
      :article, title: 'title123', visibility: 'published', collection: 'page'
    )
    create :article, title: 'title456', visibility: 'draft', collection: 'post'
    create(
      :article, title: 'title789', visibility: 'published', collection: 'post'
    )
    create(
      :article, title: 'titleabc', visibility: 'published', collection: 'post'
    )
    create(
      :article, title: 'titledef', visibility: 'published', collection: 'post'
    )

    visit content_articles_path

    expect(page).to have_content 'title789'
    expect(page).to have_content 'titleabc'
    expect(page).to have_content 'titledef'
  end
end
