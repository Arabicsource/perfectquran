# frozen_string_literal: true

require 'rails_helper'

feature 'Flagging comments' do
  scenario 'on posts' do
    blog_post = create :post, :with_comments
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
end
