# frozen_string_literal: true

require 'rails_helper'

feature 'Registration' do
  scenario 'of a new account' do
    visit new_account_registration_path

    fill_in 'Email', with: 'email@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'registration-form-submit'

    expect(page)
      .to(
        have_css(
          '.notification',
          text: 'Alhamdulillah! You have successfully registered.'
        )
      )

    expect(current_url).to eq root_url
  end
end
