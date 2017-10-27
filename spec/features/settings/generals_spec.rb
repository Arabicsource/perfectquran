# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'General Settings' do
  let(:user) { FactoryBot.create(:member) }
  before { login_as user }

  scenario 'edit a users general settings' do
    visit edit_settings_general_path

    within '#general-settings-form' do
      fill_in 'Name', with: 'Updated Name'
      fill_in 'Username', with: 'updated_username'
      fill_in 'Bio', with: 'Updated Biography Content'
      click_on 'Update Settings'
    end

    expect(page).to have_css '.alert-success',
                             text: I18n.t('settings.general.edited')
    expect(user.reload.name).to eq 'Updated Name'
    expect(user.reload.username).to eq 'updated_username'
    expect(user.reload.bio).to eq 'Updated Biography Content'
  end
end
