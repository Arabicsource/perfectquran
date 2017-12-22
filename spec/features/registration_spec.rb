# frozen_string_literal: true

require 'rails_helper'

feature 'Registration', js: true do
  scenario 'successful submission' do
    first = create :surah, id: 1, transliterated_name: 'first'
    create_list :ayah, 2, surah: first
    second = create :surah, id: 114, transliterated_name: 'second'
    create_list :ayah, 3, surah: second
    third = create :surah, id: 113, transliterated_name: 'third'
    create_list :ayah, 4, surah: third
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

    expect { click_button 'Next' }.to change(Profile, :count).by(1)

    expect { click_on 'first' }.to change(Memory, :count).by(2)
    expect { click_on 'second' }.to change(Memory, :count).by(3)
    expect { click_on 'third' }.to change(Memory, :count).by(4)
    expect { click_on 'second' }.to change(Memory, :count).by(-3)

    pending

    click_on 'Next'

    expect(page).to have_css '.notification'
  end
end
