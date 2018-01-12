# frozen_string_literal: true

require 'rails_helper'

include Warden::Test::Helpers

feature 'Connection' do
  let!(:translation) { create :translation, id: 3 }
  let(:account) { create :account }

  before { login_as account }

  scenario 'when connection is new' do
    visit accounts_connections_path

    click_on 'Connect Twitter Account'

    expect(page).to have_css(
      '.notification', text: 'Alhamdulillah, your Twitter account was connected'
    )
  end

  scenario 'when connection exists' do
    create :connection, name: 'nickname', account: account

    visit accounts_connections_path

    click_on 'Connect Twitter Account'

    expect(page).to have_css(
      '.notification',
      text: 'Alhamdulillah, your Twitter account has been updated'
    )
  end
end

feature 'Deleting Connection' do
  let(:account) { create :account }
  let!(:connection) { create :connection, account: account }

  before { login_as account }

  scenario 'when successful' do
    visit accounts_connections_path

    within "#connection-#{connection.id}" do
      click_on 'Delete'
    end

    expect(page).not_to have_text connection.name
    expect(page).not_to have_text connection.provider_uid
    expect(page).to have_css(
      '.notification',
      text: 'Alhamdulillah, your Twitter connection has been deleted'
    )
  end

  feature 'Editing Connection' do
    let(:account) { create :account }
    let!(:connection) { create :connection, account: account }

    before { login_as account }

    scenario 'when successful' do
      visit accounts_connections_path

      click_on 'Edit'

      select 'Active', from: 'connection[active]'

      click_on 'Update Connection'

      expect(page).to have_css(
        '.notification',
        text: 'Alhamdulillah, your Twitter connection has been updated'
      )
    end
  end
end
