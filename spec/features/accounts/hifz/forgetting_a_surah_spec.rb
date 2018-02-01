# frozen_string_literal: true

require 'rails_helper'

feature 'Hifz', js: true do
  scenario 'account owner forgets a surah' do
    hifz_page = Page::Hifz.new
    hifz_page.memorize_quran

    hifz_page.visit_surah
    hifz_page.forget_surah

    expect(hifz_page).to be_zero_percent_memorized
    expect(hifz_page).to have_all_ayahs_not_memorized
    expect(hifz_page).not_to have_memorized_ayahs
  end
end
