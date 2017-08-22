require 'rails_helper'

feature "Registration" do

  scenario "Successful submission" do
    # Given we have a guest
    guest = FactoryGirl.build(:guest)

    # And the guest in on the registration page
    visit new_user_registration_path
    expect(page).to have_css :h1, text: 'Register'
    expect(page).to have_title 'Register'
    expect(current_url).to match '/register'

    # When the guest completes the form
    fill_in 'Name', with: guest.name
    fill_in 'Username', with: guest.username
    fill_in 'Email', with: guest.email
    fill_in 'Password', with: guest.password
    fill_in 'Password confirmation', with: guest.password

    # And submits the form
    click_on 'Register'

    # Then expect to be on the root page
    expect(page).to have_css :h1, text: 'Suwar'
    expect(page).to have_title 'Perfect Quran'
    expect(page).to_not have_title  '|'

    # And expect to have a success message
    expect(page).to have_css '.flash-notice', text: I18n.t('devise.registrations.signed_up_but_unconfirmed')
  end
end