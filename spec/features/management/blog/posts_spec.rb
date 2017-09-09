# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Post management' do
  let(:admin) { FactoryGirl.create(:user, :confirmed, :admin) }
  let(:post_attributes) { FactoryGirl.attributes_for(:post) }
  before { login_as admin }

  describe 'create' do
    scenario 'successfully' do
      visit new_manage_post_path
      fill_in 'Title', with: post_attributes[:title]
      fill_in 'Content', with: post_attributes[:content]
      click_on 'Create Post'
      expect(page).to have_css '.alert-success',
                               text: I18n.t('manage.post.created')
      expect(page).to have_text post_attributes[:title]
    end
  end
end
