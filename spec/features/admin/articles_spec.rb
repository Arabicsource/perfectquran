# frozen_string_literal: true

require 'rails_helper'

feature 'New Article', js: true do
  include JavascriptHelper

  scenario 'when successful' do
    create :category, name: 'cat123'
    login_as create :admin
    visit admin_articles_path
    click_on 'New'

    fill_in 'Title', with: 'title123'
    fill_in_trix_editor('content123')
    select 'cat123', from: 'Category'
    click_on 'Create Article'

    expect(page).to have_css '.notification', text: 'article was added'
    expect(page).to have_text 'title123'
    expect(current_path).to eq admin_articles_path
  end

  scenario 'when failure' do
    login_as create :admin
    visit new_admin_article_path

    click_on 'Create Article'

    expect(page).to_not have_css '.notification', text: 'article was added'
    expect(page).to have_css '.notification', text: "Title can't be blank"
    expect(current_path).to eq new_admin_article_path
  end
end

feature 'Edit Article', js: true do
  let(:admin) { create :admin }
  let!(:article) { create :article, title: 'title123' }

  scenario 'when successful' do
    login_as admin
    visit admin_articles_path

    click_on article.id
    click_on 'Edit'

    fill_in 'Title',	with: 'titleabc'
    click_on 'Update Article'

    expect(page).to have_css '.notification', text: 'article was updated'
    expect(page).to_not have_text 'title123'
    expect(page).to have_text 'titleabc'
    expect(current_path).to eq admin_articles_path
  end

  scenario 'when failure' do
    login_as admin
    visit edit_admin_article_path(article)

    fill_in 'Title',	with: ''
    click_on 'Update Article'

    expect(page).to_not have_css '.notification', text: 'article was updated'
    expect(page).to have_css '.notification', text: "Title can't be blank"
    expect(current_path).to eq edit_admin_article_path(article)
  end
end

feature 'Delete City', js: true do
  let(:admin) { create :admin }
  let(:article) { create :article, title: 'title123' }
  let(:comment) { create :comment, article: article }

  scenario 'when successful' do
    article
    login_as admin
    visit admin_articles_path

    click_on article.id
    click_on 'Delete'

    expect(page).to have_css '.notification', text: 'article was deleted'
    expect(page).to_not have_text 'title123'
    expect(current_path).to eq admin_articles_path
  end

  scenario 'when failure' do
    comment
    login_as admin
    visit admin_article_path(article)

    click_on 'Delete'

    expect(page).to have_css '.notification', text: 'article was not deleted'
    expect(page).to have_text 'title123'
    expect(current_path).to eq admin_article_path(article)
  end
end
