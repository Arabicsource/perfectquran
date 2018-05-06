# frozen_string_literal: true

require 'rails_helper'

feature 'New Category', js: true do
  scenario 'when successful' do
    login_as create :admin
    visit admin_categories_path
    click_on 'New'

    fill_in 'Name', with: 'category123'
    fill_in 'Description', with: 'descrition231'
    click_on 'Create Category'

    expect(page).to have_css '.notification', text: 'category was added'
    expect(page).to have_text 'category123'
    expect(current_path).to eq admin_categories_path
  end

  scenario 'when failure' do
    login_as create :admin
    visit new_admin_category_path

    click_on 'Create Category'

    expect(page).to_not have_css '.notification', text: 'category was added'
    expect(page).to have_css '.notification', text: "Name can't be blank"
    expect(current_path).to eq new_admin_category_path
  end
end

feature 'Edit Category', js: true do
  let(:admin) { create :admin }
  let!(:category) { create :category, name: 'category123' }

  scenario 'when successful' do
    login_as admin
    visit admin_categories_path

    click_on category.id
    click_on 'Edit'

    fill_in 'Name',	with: 'categoryabc'
    click_on 'Update Category'

    expect(page).to have_css '.notification', text: 'category was updated'
    expect(page).to_not have_text 'category123'
    expect(page).to have_text 'categoryabc'
    expect(current_path).to eq admin_categories_path
  end

  scenario 'when failure' do
    login_as admin
    visit edit_admin_category_path(category)

    fill_in 'Name',	with: ''
    click_on 'Update Category'

    expect(page).to_not have_css '.notification', text: 'category was updated'
    expect(page).to have_css '.notification', text: "Name can't be blank"
    expect(current_path).to eq edit_admin_category_path(category)
  end
end

feature 'Delete Category', js: true do
  let(:admin) { create :admin }
  let(:category) { create :category, name: 'category123' }
  let(:article) { create :article, category: category }

  scenario 'when successful' do
    category
    login_as admin
    visit admin_categories_path

    click_on category.id
    click_on 'Delete'

    expect(page).to have_css '.notification', text: 'category was deleted'
    expect(page).to_not have_text 'category123'
    expect(current_path).to eq admin_categories_path
  end

  scenario 'when failure' do
    article
    login_as admin
    visit admin_category_path(category)

    click_on 'Delete'

    expect(page).to have_css '.notification', text: 'category was not deleted'
    expect(page).to have_text 'category123'
    expect(current_path).to eq admin_category_path(category)
  end
end
