# frozen_string_literal: true

require 'rails_helper'

feature 'New State', js: true do
  scenario 'when successful' do
    create :country, name: 'country123'
    login_as create :admin
    visit admin_states_path
    click_on 'New'

    fill_in 'Name', with: 'state123'
    fill_in 'Code', with: 'ST'
    select 'country123', from: 'Country'
    click_on 'Create State'

    expect(page).to have_css '.notification', text: 'state was added'
    expect(page).to have_text 'state123'
    expect(current_path).to eq admin_states_path
  end

  scenario 'when failure' do
    login_as create :admin
    visit new_admin_state_path

    click_on 'Create State'

    expect(page).to_not have_css '.notification', text: 'state was added'
    expect(page).to have_css '.notification', text: "Name can't be blank"
    expect(current_path).to eq new_admin_state_path
  end
end

feature 'Edit State', js: true do
  let(:admin) { create :admin }
  let!(:state) { create :state, name: 'state123' }

  scenario 'when successful' do
    login_as admin
    visit admin_states_path

    click_on state.id
    click_on 'Edit'

    fill_in 'Name',	with: 'stateabc'
    click_on 'Update State'

    expect(page).to have_css '.notification', text: 'state was updated'
    expect(page).to_not have_text 'state123'
    expect(page).to have_text 'stateabc'
    expect(current_path).to eq admin_states_path
  end

  scenario 'when failure' do
    login_as admin
    visit edit_admin_state_path(state)

    fill_in 'Name',	with: ''
    click_on 'Update State'

    expect(page).to_not have_css '.notification', text: 'state was updated'
    expect(page).to have_css '.notification', text: "Name can't be blank"
    expect(current_path).to eq edit_admin_state_path(state)
  end
end

feature 'Delete State', js: true do
  let(:admin) { create :admin }
  let(:state) { create :state, name: 'state123' }
  let(:city) { create :city, state: state }

  scenario 'when successful' do
    state
    login_as admin
    visit admin_states_path

    click_on state.id
    click_on 'Delete'

    expect(page).to have_css '.notification', text: 'state was deleted'
    expect(page).to_not have_text 'state123'
    expect(current_path).to eq admin_states_path
  end

  scenario 'when failure' do
    city
    login_as admin
    visit admin_state_path(state)

    click_on 'Delete'

    expect(page).to have_css '.notification', text: 'state was not deleted'
    expect(page).to have_text 'state123'
    expect(current_path).to eq admin_state_path(state)
  end
end
