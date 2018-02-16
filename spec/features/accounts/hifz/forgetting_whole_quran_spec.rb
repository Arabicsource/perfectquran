# frozen_string_literal: true

require 'rails_helper'

feature 'Hifz', js: true do
  scenario 'account owner forgets all' do
    hifz_page = Page::Hifz.new
    hifz_page.memorize_quran

    expect(hifz_page).to be_one_hundred_percent_memorized

    hifz_page.forget_quran

    expect(hifz_page).to be_zero_percent_memorized
    expect(hifz_page).to have_all_surahs_not_memorized
    expect(hifz_page).not_to have_partially_memorized_surahs
    expect(hifz_page).not_to have_memorized_surahs
  end
end
