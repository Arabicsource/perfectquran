# frozen_string_literal: true

require 'rails_helper'

include Warden::Test::Helpers

feature 'Connection' do
  let(:account) { create :account }

  before { login_as account }

  scenario 'when connection is new' do
    visit accounts_connections_path

    click_on 'Connect Twitter Account'

    expect(page).to have_selector 'td', text: 'twitter'
    expect(page).to have_selector 'td', text: 'nickname123'
    expect(page).to have_selector 'td', text: 'uid12345'
    expect(page).to have_css(
      '.notification', text: 'Alhamdulillah, your Twitter account was connected'
    )
  end

  scenario 'when connection exists' do
    create :connection, name: 'nickname', account: account

    visit accounts_connections_path

    click_on 'Connect Twitter Account'

    expect(page).to have_selector 'td', text: 'twitter'
    expect(page).to have_selector 'td', text: 'nickname123'
    expect(page).to have_selector 'td', text: 'uid12345'
    expect(page).to have_css(
      '.notification',
      text: 'Alhamdulillah, your Twitter account has been updated'
    )
  end
end
