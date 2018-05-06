# frozen_string_literal: true

require 'rails_helper'

feature 'New Mosque', js: true do
  scenario 'when successful' do
    create :city, name: 'city123'
    login_as create :admin
    visit admin_mosques_path
    click_on 'New'

    fill_in 'Name', with: 'name123'
    fill_in 'Phone',	with: '1111111111'
    fill_in 'Email',	with: 'info@mosqueemail.com'
    fill_in 'Street', with: '123 Main St.'
    select 'city123', from: 'Location'
    fill_in 'Zip Code', with: '12345'
    fill_in 'Website', with: 'mosquewebsite.com'
    click_on 'Create Mosque'

    expect(page).to have_css '.notification', text: 'mosque was added'
    expect(page).to have_text 'name123'
    expect(current_path).to eq admin_mosques_path
  end

  scenario 'when failure' do
    login_as create :admin
    visit new_admin_mosque_path

    click_on 'Create Mosque'

    expect(page).to_not have_css '.notification', text: 'mosque was added'
    expect(page).to have_css '.notification', text: "Name can't be blank"
    expect(current_path).to eq new_admin_mosque_path
  end
end

feature 'Edit Mosque', js: true do
  let(:admin) { create :admin }
  let!(:mosque) { create :mosque, name: 'mosque123' }

  scenario 'when successful' do
    login_as admin
    visit admin_mosques_path

    click_on mosque.id
    click_on 'Edit'

    fill_in 'Name',	with: 'mosqueabc'
    click_on 'Update Mosque'

    expect(page).to have_css '.notification', text: 'mosque was updated'
    expect(page).to_not have_text 'mosque123'
    expect(page).to have_text 'mosqueabc'
    expect(current_path).to eq admin_mosques_path
  end

  scenario 'when failure' do
    login_as admin
    visit edit_admin_mosque_path(mosque)

    fill_in 'Name',	with: ''
    click_on 'Update Mosque'

    expect(page).to_not have_css '.notification', text: 'mosque was updated'
    expect(page).to have_css '.notification', text: "Name can't be blank"
    expect(current_path).to eq edit_admin_mosque_path(mosque)
  end
end

feature 'Delete Mosque', js: true do
  let(:admin) { create :admin }
  let(:mosque) { create :mosque, name: 'mosque123' }

  scenario 'when successful' do
    mosque
    login_as admin
    visit admin_mosques_path

    click_on mosque.id
    click_on 'Delete'

    expect(page).to have_css '.notification', text: 'mosque was deleted'
    expect(page).to_not have_text 'mosque123'
    expect(current_path).to eq admin_mosques_path
  end
end
