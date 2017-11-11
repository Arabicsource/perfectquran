# frozen_string_literal: true

require 'rails_helper'

feature 'Commenting' do
  scenario 'create a new comment on blog post' do
    post = create :post
    login_as create :member
    visit blog_post_path(post.permalink)

    fill_in 'Content', with: 'abc123'
    click_on 'Create Comment'

    expect(page).to have_css '.alert-success',
                             text: I18n.t('blog.comment.created')
    expect(page).to have_text 'abc123'
  end
end
