# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Comments management' do
  let(:admin) { FactoryBot.create(:admin) }
  let(:comment) { FactoryBot.create(:comment) }
  let(:flagged_comment) { FactoryBot.create(:comment, :with_flag) }

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
