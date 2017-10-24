# frozen_string_literal: true

require 'rails_helper'

feature 'Registration' do
  scenario 'successful submission' do
    attributes = FactoryGirl.attributes_for :user
    visit new_user_registration_path

    fill_in 'Name', with: attributes[:name]
    fill_in 'Username', with: attributes[:username]
    fill_in 'Email', with: attributes[:email]
    fill_in 'Password', with: attributes[:password]
    fill_in 'Password confirmation', with: attributes[:password]
    click_button 'Register'

    expect(page)
      .to have_css '.alert-notice',
                   text: I18n
                     .t('devise.registrations.signed_up_but_unconfirmed')
  end
end
