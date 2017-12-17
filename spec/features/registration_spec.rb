# frozen_string_literal: true

require 'rails_helper'

feature 'Registration' do
  scenario 'successful submission' do
    visit new_account_registration_path

    fill_in 'Email', with: 'example@perfectquran.co'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    expect { click_button 'Next' }.to change(Account, :count).by(1)

    within '#profile_form' do
      fill_in 'Name', with: 'name'
      fill_in 'Username', with: 'username'
      fill_in 'Bio', with: 'bio'
    end

    expect { click_button 'Finished' }.to change(Profile, :count).by(1)
  end
end
