# frozen_string_literal: true

require 'rails_helper'

feature 'Email Preferences' do
  let(:account) { create :account }
  let(:updater) { double(:updater) }
  let(:successful_response) { OpenStruct.new(successful?: true) }

  background do
    login_as account
    visit edit_account_profile_path

    click_on 'Email Preferences'
  end

  scenario 'for newly created account' do
    expect(page)
      .to(have_field('account_email_preference_general', checked: true))
    expect(page)
      .to(have_field('account_email_preference_daily_ayah', checked: false))
  end

  scenario 'when account unsubscribes from general' do
    allow(MailingList::Updater).to(
      receive(:new).with(account.email).and_return(updater)
    )

    allow(updater).to(
      receive(:unsubscribe).and_return(successful_response)
    )

    page.find('#account_email_preference_general').set(false)
    click_on 'Save Email Preferences'

    expect(page)
      .to(have_field('account_email_preference_general', checked: false))
    expect(page)
      .to(
        have_css(
          '.notification',
          text: 'Your email preferences have been updated'
        )
      )
  end

  scenario 'when account subscribes to daily ayahs' do
    allow(MailingList::Updater).to(
      receive(:new).with(account.email).and_return(updater)
    )

    allow(updater).to(
      receive(:subscribe_to_daily_ayah).and_return(successful_response)
    )

    page.find('#account_email_preference_daily_ayah').set(true)
    click_on 'Save Email Preferences'

    expect(page)
      .to(have_field('account_email_preference_daily_ayah', checked: true))
    expect(page)
      .to(
        have_css(
          '.notification', text: 'Your email preferences have been updated'
        )
      )
  end

  scenario 'when account unsubscribes from daily ayah' do
    account.email_preference.toggle!(:daily_ayah)

    allow(MailingList::Updater).to(
      receive(:new).with(account.email).and_return(updater)
    )

    allow(updater).to(
      receive(:unsubscribe_from_daily_ayah).and_return(successful_response)
    )

    page.find('#account_email_preference_daily_ayah').set(false)
    click_on 'Save Email Preferences'

    expect(page)
      .to(have_field('account_email_preference_daily_ayah', checked: false))
    expect(page)
      .to(
        have_css(
          '.notification',
          text: 'Your email preferences have been updated'
        )
      )
  end
end
