# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Post management' do
  let(:admin) { FactoryGirl.create(:user, :confirmed, :admin) }
  let(:post_attributes) { FactoryGirl.attributes_for(:post) }
  let(:post) { FactoryGirl.create(:post) }
  let(:category) { FactoryGirl.create(:category) }
  before { login_as admin }

  scenario 'create a new post' do
    category
    visit new_manage_post_path
    fill_in 'Title', with: post_attributes[:title]
    select category.name, from: 'Category'
    fill_in 'Content', with: post_attributes[:content]
    click_on 'Create Post'
    expect(page).to have_css '.alert-success',
                             text: I18n.t('manage.post.created')
    expect(page).to have_text post_attributes[:title]
  end

  scenario 'edit a post' do
    visit edit_manage_post_path(post)
    fill_in 'Title', with: 'ModifiedPostTitle'
    click_on 'Update Post'
    expect(page).to have_css '.alert-success',
                             text: I18n.t('manage.post.edited')
    expect(page).to have_text 'ModifiedPostTitle'
  end
end
