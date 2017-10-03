# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Categories management' do
  let(:admin) { FactoryGirl.create(:user, :confirmed, :admin) }
  let(:category_attributes) { FactoryGirl.attributes_for(:category) }
  let(:category) { FactoryGirl.create(:category) }
  before { login_as admin }

  scenario 'create a new category' do
    visit new_manage_category_path
    fill_in 'Name', with: category_attributes[:name]
    click_on 'Create Category'
    expect(page).to have_css '.alert-success', text: I18n.t('manage.category.created')
    expect(page).to have_text category_attributes[:name]
  end

  scenario 'edit a category' do
    visit edit_manage_category_path(category)
    fill_in 'Name', with: 'ModifiedCategoryName'
    click_on 'Update Category'
    expect(page).to have_css '.alert-success', text: I18n.t('manage.category.edited')
    expect(page).to have_text 'ModifiedCategoryName'
  end

  scenario 'delete a category' do
    visit manage_category_path(category)
    click_on 'Delete'
    expect(page).to have_css '.alert-success', text: I18n.t('manage.category.deleted')
    expect(page).not_to have_text category.name
  end
end
