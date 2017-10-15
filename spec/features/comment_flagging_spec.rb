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
end
