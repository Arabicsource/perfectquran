# frozen_string_literal: true

require 'rails_helper'

feature 'Contacting', js: true do
  scenario 'as guest' do
    visit new_contact_path

    fill_in 'Name',	with: "name123"
    fill_in 'Email',	with: "email@perfectquran.com"
    fill_in 'Message',	with: 'message123'
    click_on 'Send'

    expect(page).to have_css '.notification', text: 'your message was sent'
    expect(current_path).to eq new_contact_path
  end

  scenario 'as guest when form incomplete' do
    visit new_contact_path

    click_on 'Send'

    expect(page).to have_css '.notification', text: 'your message was not sent'
    expect(current_path).to eq new_contact_path
  end
end
