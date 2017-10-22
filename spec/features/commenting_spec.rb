# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Commenting' do
  let(:comment_attributes) { FactoryGirl.attributes_for(:comment) }
  let(:user) { FactoryGirl.create(:user, :confirmed) }
  let(:post) { FactoryGirl.create(:post) }
  let(:ayah) { Quran::Ayah.first }

  before { login_as user }

  scenario 'create a new comment on blog post' do
    visit blog_post_path(post.permalink)
    fill_in 'Content', with: comment_attributes[:content]
    click_on 'Create Comment'
    expect(page).to have_css '.alert-success',
                             text: I18n.t('blog.comment.created')
    expect(page).to have_text comment_attributes[:content]
  end

  scenario 'create a new comment on ayah' do
    visit ayah_by_number_path(ayah.surah.id, ayah.number)
    fill_in 'Content', with: comment_attributes[:content]
    click_on 'Create Comment'
    expect(page).to have_css '.alert-success',
                             text: I18n.t('comment.created')
    expect(page).to have_text comment_attributes[:content]
  end
end
