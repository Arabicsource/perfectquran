# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Comments management' do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:comment) { FactoryGirl.create(:comment) }
  let(:flagged_comment) { FactoryGirl.create(:comment, :with_flag) }

  before { login_as admin }

  scenario 'delete a comment' do
    visit manage_comment_path(comment)
    click_on 'Delete'
    expect(page).to have_css '.alert-success',
                             text: I18n.t('manage.comment.deleted')
    expect(page).not_to have_text comment.content
  end

  scenario 'approve a comment' do
    visit manage_comment_path(flagged_comment)
    click_on 'Approve'
    expect(page).to have_css '.alert-success',
                             text: I18n.t('manage.comment.approved')
    expect(page).not_to have_link 'Approve'
  end
end
