require 'rails_helper'

feature "Registration" do

  before do
    # Given we have a guest
    @guest = FactoryGirl.build(:guest)

    # And the guest in on the registration page
    visit new_user_registration_path
    expect(page).to have_css :h1, text: 'Register'
    expect(page).to have_title 'Register'
    expect(current_url).to match '/register'
  end

  scenario "Successful submission" do
    # When the guest completes the form
    fill_in 'Name', with: @guest.name
    fill_in 'Username', with: @guest.username
    fill_in 'Email', with: @guest.email
    fill_in 'Password', with: @guest.password
    fill_in 'Password confirmation', with: @guest.password

    # And submits the form
    click_on 'Register'

    # Then expect to be on the root page
    expect(page).to have_css :h1, text: 'Suwar'
    expect(page).to have_title 'Perfect Quran'
    expect(page).to_not have_title  '|'

    # And expect to have a success message
    expect(page).to have_css '.flash-notice', text: I18n.t('devise.registrations.signed_up_but_unconfirmed')
  end

  scenario "incomplete submission" do
    # When the guest submits an incomplete form
    click_on 'Register'

    # Then expect to be on the registration page
    expect(page).to have_css :h1, text: 'Register'
    expect(page).to have_title 'Register'

    # And expect to have an error message
    within '#error_explanation' do
      expect(page).to have_text '5 errors prohibited this user from being saved:'
    end
  end

  scenario 'submission with duplicate username' do
    # Given there is a user saved in the database
    user = FactoryGirl.create(:user)

    # When the guest submits a form with a duplicate username
    fill_in 'Name', with: @guest.name
    fill_in 'Username', with: user.username
    fill_in 'Email', with: @guest.email
    fill_in 'Password', with: @guest.password
    fill_in 'Password confirmation', with: @guest.password
    click_on 'Register'

    # Then expect to be on the registration page
    expect(page).to have_css :h1, text: 'Register'
    expect(page).to have_title 'Register'

    # And expect to have an error message
    within '#error_explanation' do
      expect(page).to have_text 'Username has already been taken'
    end
  end

  scenario 'submission with a name that is too short' do
    # When the guest submits a form with a name that is too short
    fill_in 'Name', with: 'aa'
    fill_in 'Username', with: @guest.username
    fill_in 'Email', with: @guest.email
    fill_in 'Password', with: @guest.password
    fill_in 'Password confirmation', with: @guest.password
    click_on 'Register'

    # Then expect to be on the registration page
    expect(page).to have_css :h1, text: 'Register'
    expect(page).to have_title 'Register'

    # And expect to have an error message
    within '#error_explanation' do
      expect(page).to have_text 'Name is too short (minimum is 3 characters)'
    end
  end
end