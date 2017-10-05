# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Page management' do
  let(:admin) { FactoryGirl.create(:user, :confirmed, :admin) }
  let(:page_attributes) { FactoryGirl.attributes_for(:page) }
  let(:page_obj) { FactoryGirl.create(:page) }
  before { login_as admin }

  describe 'create' do
    scenario 'successfully' do
      visit new_manage_page_path
      fill_in 'Title', with: page_attributes[:title]
      fill_in 'Content', with: page_attributes[:content]
      click_on 'Create Page'
      expect(page).to have_css '.alert-success',
                               text: I18n.t('manage.page.created')
      expect(page).to have_text page_attributes[:title]
    end
  end

  describe 'edit' do
    scenario 'successfully' do
      visit edit_manage_page_path(page_obj)
      fill_in 'Title', with: 'ModifiedPageTitle'
      click_on 'Update Page'
      expect(page).to have_css '.alert-success',
                               text: I18n.t('manage.page.edited')
      expect(page).to have_text 'ModifiedPageTitle'
    end
  end
end
