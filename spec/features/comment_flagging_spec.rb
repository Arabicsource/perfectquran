# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Flagging comments' do
  scenario 'on posts' do
    blog_post = FactoryGirl.create(:post, :with_comments)

    visit blog_post_path(blog_post.permalink)
    within "#comment-#{blog_post.comments.first.id}" do
      click_on 'Flag'
    end
    fill_in 'Reason', with: 'string'
    click_on 'Flag Comment'

    expect(current_url).to match "/blog/posts/#{blog_post.permalink}"
    expect(page).to have_css '.alert-success',
                             text: I18n.t('comment.flagged')

    expect(page).not_to have_text blog_post.comments.first.content
  end

  scenario 'on ayahs' do
    ayah = Ayah.first
    FactoryGirl.create_list(:comment, 3, commentable: ayah)

    visit quran_ayah_path ayah
    within "#comment-#{ayah.comments.first.id}" do
      click_on 'Flag'
    end
    fill_in 'Reason', with: 'string'
    click_on 'Flag Comment'

    expect(current_url).to match "/quran/ayahs/#{ayah.id}"
    expect(page).to have_css '.alert-success',
                             text: I18n.t('comment.flagged')
    expect(page).not_to have_text ayah.comments.first.content
  end
end
