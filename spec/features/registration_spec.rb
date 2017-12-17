# frozen_string_literal: true

require 'rails_helper'

feature 'Registration' do
  scenario 'successful submission' do
    attributes = FactoryBot.attributes_for :account
    visit new_account_registration_path

    within '#registration-form' do
      fill_in 'Name', with: attributes[:name]
      fill_in 'Username', with: attributes[:username]
      fill_in 'Email', with: attributes[:email]
      fill_in 'Password', with: attributes[:password]
      fill_in 'Password confirmation', with: attributes[:password]
      click_button 'Register'
    end

    expect(page)
      .to have_css '.notification',
                   text: I18n
                     .t('devise.registrations.signed_up_but_unconfirmed')
  end
end
