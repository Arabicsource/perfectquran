# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Hifz', js: true do
  scenario 'account owner memorizes all' do
    create_list :surah, 5, :with_ayahs

    account = create :account
    login_as account
    visit accounts_memory_path

    expect(Memory.count).to eq 0
    expect(page).to have_text '0% Memorized'

    click_on 'Memorize All'

    expect(Memory.count).to eq 15
    expect(page).to have_text '0.002%' # represents 100%

    within '#not-memorized' do
      expect(page).not_to have_css '.button'
    end

    within '#partially-memorized' do
      expect(page).not_to have_css '.button'
    end

    within '#memorized' do
      expect(page).to have_css '.button', count: 5
    end
  end

  scenario 'account owner forgets all' do
    account = create :account
    create_list :surah, 5, :with_ayahs

    Quran::Ayah.all.each do |ayah|
      Memory.create(account: account, ayah: ayah)
    end

    login_as account
    visit accounts_memory_path

    expect(Memory.count).to eq 15

    click_on 'Forget All'

    expect(Memory.count).to eq 0
    expect(page).to have_text '0%'

    within '#not-memorized' do
      expect(page).to have_css '.button', count: 5
    end

    within '#partially-memorized' do
      expect(page).not_to have_css '.button'
    end

    within '#memorized' do
      expect(page).not_to have_css '.button'
    end
  end
end
