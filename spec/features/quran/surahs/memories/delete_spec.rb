# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers
include JavascriptHelper

feature 'Forget a surah', js: true do
  scenario 'successfully' do
    account = create :account
    surah = create :surah, id: 1
    ayahs = create_list :ayah, 3, surah: surah

    ayahs.each do |ayah|
      create :memory, ayah: ayah, account: account
    end

    login_as account
    visit quran_surah_path(surah)
    click_on 'Memory'

    expect(page).to have_css '.not-memorized', text: 'Memory'
  end
end
