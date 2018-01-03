# frozen_string_literal: true

require 'rails_helper'

feature 'Registration', js: true do
  let(:stripe_helper) { StripeMock.create_test_helper }

  before do
    first = create :surah, id: 1, transliterated_name: 'first'
    create_list :ayah, 2, surah: first
    second = create :surah, id: 114, transliterated_name: 'second'
    create_list :ayah, 3, surah: second
    third = create :surah, id: 113, transliterated_name: 'third'
    create_list :ayah, 4, surah: third
  end

  scenario 'best case' do
    visit new_account_registration_path

    fill_in 'Email', with: 'example@perfectquran.co'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    expect { click_button 'Next' }.to change(Account, :count).by(1)

    fill_in 'Name', with: 'name123'
    fill_in 'Username', with: 'username123'
    fill_in 'Bio', with: 'bio123'

    expect { click_button 'Next' }.to change(Profile, :count).by(1)

    expect { click_on 'first' }.to change(Memory, :count).by(2)
    expect { click_on 'second' }.to change(Memory, :count).by(3)
    expect { click_on 'third' }.to change(Memory, :count).by(4)
    expect { click_on 'second' }.to change(Memory, :count).by(-3)

    click_on 'Next'

    click_on 'Cancel'

    expect(current_path).to eql accounts_profile_path
  end
end
