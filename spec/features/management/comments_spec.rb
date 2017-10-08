# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Comments management' do
  let(:admin) { FactoryGirl.create(:user, :confirmed, :admin) }
  let(:comment_attributes) { FactoryGirl.attributes_for(:comment) }
  let(:comment) { FactoryGirl.create(:comment) }
  before { login_as admin }

  scenario 'delete a comment' do
    visit manage_comment_path(comment)
    click_on 'Delete'
    expect(page).to have_css '.alert-success',
                             text: I18n.t('manage.comment.deleted')
    expect(page).not_to have_text comment.content
  end
end
