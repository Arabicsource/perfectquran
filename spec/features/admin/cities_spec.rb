# frozen_string_literal: true

require 'rails_helper'

feature 'New City', js: true do
  scenario 'when successful' do
    create :state, name: 'state123'
    login_as create :admin
    visit admin_cities_path
    click_on 'New'

    fill_in 'Name', with: 'city123'
    fill_in 'Code', with: 'CI'
    select 'state123', from: 'State'
    click_on 'Create City'

    expect(page).to have_css '.notification', text: 'city was added'
    expect(page).to have_text 'city123'
    expect(current_path).to eq admin_cities_path
  end

  scenario 'when failure' do
    login_as create :admin
    visit new_admin_city_path

    click_on 'Create City'

    expect(page).to_not have_css '.notification', text: 'city was added'
    expect(page).to have_css '.notification', text: "Name can't be blank"
    expect(current_path).to eq new_admin_city_path
  end
end

feature 'Edit City', js: true do
  let(:admin) { create :admin }
  let!(:city) { create :city, name: 'city123' }

  scenario 'when successful' do
    login_as admin
    visit admin_cities_path

    click_on city.id
    click_on 'Edit'

    fill_in 'Name',	with: 'cityabc'
    click_on 'Update City'

    expect(page).to have_css '.notification', text: 'city was updated'
    expect(page).to_not have_text 'city123'
    expect(page).to have_text 'cityabc'
    expect(current_path).to eq admin_cities_path
  end

  scenario 'when failure' do
    login_as admin
    visit edit_admin_city_path(city)

    fill_in 'Name',	with: ''
    click_on 'Update City'

    expect(page).to_not have_css '.notification', text: 'city was updated'
    expect(page).to have_css '.notification', text: "Name can't be blank"
    expect(current_path).to eq edit_admin_city_path(city)
  end
end

feature 'Delete City', js: true do
  let(:admin) { create :admin }
  let(:city) { create :city, name: 'city123' }
  let(:mosque) { create :mosque, city: city }

  scenario 'when successful' do
    city
    login_as admin
    visit admin_cities_path

    click_on city.id
    click_on 'Delete'

    expect(page).to have_css '.notification', text: 'city was deleted'
    expect(page).to_not have_text 'city123'
    expect(current_path).to eq admin_cities_path
  end

  scenario 'when failure' do
    mosque
    login_as admin
    visit admin_city_path(city)

    click_on 'Delete'

    expect(page).to have_css '.notification', text: 'city was not deleted'
    expect(page).to have_text 'city123'
    expect(current_path).to eq admin_city_path(city)
  end
end
