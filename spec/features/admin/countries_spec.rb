# frozen_string_literal: true

require 'rails_helper'

feature 'New Country', js: true do
  scenario 'when successful' do
    login_as create :admin
    visit admin_countries_path
    click_on 'New'

    fill_in 'Name', with: 'country123'
    fill_in 'Code', with: 'CO'
    click_on 'Create Country'

    expect(page).to have_css '.notification', text: 'country was added'
    expect(page).to have_text 'country123'
    expect(current_path).to eq admin_countries_path
  end

  scenario 'when failure' do
    login_as create :admin
    visit new_admin_country_path

    click_on 'Create Country'

    expect(page).to_not have_css '.notification', text: 'country was added'
    expect(page).to have_css '.notification', text: "Name can't be blank"
    expect(current_path).to eq new_admin_country_path
  end
end

feature 'Edit Country', js: true do
  let(:admin) { create :admin }
  let!(:country) { create :country, name: 'country123' }

  scenario 'when successful' do
    login_as admin
    visit admin_countries_path

    click_on country.id
    click_on 'Edit'

    fill_in 'Name',	with: 'countryabc'
    click_on 'Update Country'

    expect(page).to have_css '.notification', text: 'country was updated'
    expect(page).to_not have_text 'country123'
    expect(page).to have_text 'countryabc'
    expect(current_path).to eq admin_countries_path
  end

  scenario 'when failure' do
    login_as admin
    visit edit_admin_country_path(country)

    fill_in 'Name',	with: ''
    click_on 'Update Country'

    expect(page).to_not have_css '.notification', text: 'country was updated'
    expect(page).to have_css '.notification', text: "Name can't be blank"
    expect(current_path).to eq edit_admin_country_path(country)
  end
end

feature 'Delete Country', js: true do
  let(:admin) { create :admin }
  let(:country) { create :country, name: 'country123' }
  let(:state) { create :state, country: country }

  scenario 'when successful' do
    country
    login_as admin
    visit admin_countries_path

    click_on country.id
    click_on 'Delete'

    expect(page).to have_css '.notification', text: 'country was deleted'
    expect(page).to_not have_text 'country123'
    expect(current_path).to eq admin_countries_path
  end

  scenario 'when failure' do
    state
    login_as admin
    visit admin_country_path(country)

    click_on 'Delete'

    expect(page).to have_css '.notification', text: 'country was not deleted'
    expect(page).to have_text 'country123'
    expect(current_path).to eq admin_country_path(country)
  end
end
