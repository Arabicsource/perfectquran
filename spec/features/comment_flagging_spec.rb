# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Comment Flagging' do
  scenario 'comment is flagged by guest' do
    post = FactoryGirl.create(:post, :with_comments)
    visit blog_post_path(post.permalink)

    within "#comment-#{post.comments.first.id}" do
      click_on 'Flag'
    end

    fill_in 'Reason', with: 'string'
    click_on 'Flag Comment'

    expect(page).to have_css '.alert-success',
                             text: I18n.t('comment.flagged')
    expect(page).not_to have_text post.comments.first.content
  end

  scenario 'ayah comment is flagged by guest' do
    ayah = Ayah.first
    FactoryGirl.create_list(:comment, 3, commentable: ayah)
    visit ayah_by_number_path(ayah.surah.id, ayah.number)

    within "#comment-#{ayah.comments.first.id}" do
      click_on 'Flag'
    end

    fill_in 'Reason', with: 'string'
    click_on 'Flag Comment'

    expect(page).to have_css '.alert-success',
                             text: I18n.t('comment.flagged')
    expect(page).not_to have_text ayah.comments.first.content
  end
end
