# frozen_string_literal: true

require 'rails_helper'

feature 'Account Translations', js: true do
  let(:account) { create :account }

  scenario 'account adds study translations' do
    login_as account
    visit edit_account_quran_preference_path
    click_on 'Add Study Translation'

    select 'Uthmani', from: 'account_translation_translation_id'
    within 'form#study-translation' do
      click_on 'Add Study Translation'
    end

    expect(page)
      .to(
        have_css(
          '.notification',
          text: 'Alhamdulillah, the study translation was added.'
        )
      )

    expect(page).to have_text 'Uthmani'
    expect(page).to have_text 'Arabic'
    expect(page).to have_text 'Primary'
  end

  scenario 'account deletes study translations' do
    login_as account
    create :account_translation, account: account
    visit edit_account_quran_preference_path

    expect(page).to have_text 'translation_name'
    expect(page).to have_text 'language_name'
    expect(page).to have_text 'Primary'

    find('a.delete').click
    page.driver.browser.switch_to.alert.accept

    expect(page).to_not have_text 'translation_name'
    expect(page).to_not have_text 'language_name'
    expect(page).to_not have_text 'Primary'
  end
end
