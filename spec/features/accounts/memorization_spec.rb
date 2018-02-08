# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Hifz', js: true do
  let!(:surahs) { create_list :surah, 5, :with_ayahs }
  let!(:account) { create :account }

  before { login_as account }

  scenario 'account owner memorizes a surah' do
    visit account_memory_path
    click_on surahs.first

    expect(Memory.count).to eq 0
    expect(page).to have_text '0% Memorized'

    click_on 'Memorize Surah'

    expect(Memory.count).to eq 3
    expect(page).to have_text '300% Memorized' # represents 100%

    within '#not-memorized' do
      expect(page).not_to have_css '.card'
    end

    within '#memorized' do
      expect(page).to have_css '.card', count: 3
    end
  end

  scenario 'account owner memorizes an ayah' do
    visit account_memory_path
    click_on surahs.first

    expect(Memory.count).to eq 0

    page.find(:xpath, "//*[text()='#{surahs.first.ayahs.first}']").click
    click_on 'Memorize'

    expect(Memory.count).to eq 1
    expect(page).to have_text '0%'

    within '#not-memorized' do
      expect(page).to have_css '.card', count: 2
    end

    within '#memorized' do
      expect(page).to have_css '.card', count: 1
    end
  end

  scenario 'account forgets an ayah' do
    create :memory, ayah: surahs.first.ayahs.first, account: account

    visit account_memory_path
    click_on surahs.first

    expect(Memory.count).to eq 1

    page.find(:xpath, "//*[text()='#{surahs.first.ayahs.first}']").click

    within '#memorized' do
      click_on 'Forget'
    end

    expect(Memory.count).to eq 0
    expect(page).to have_text '0%'

    within '#not-memorized' do
      expect(page).to have_css '.card', count: 3
    end

    within '#memorized' do
      expect(page).not_to have_css '.card'
    end
  end
end
