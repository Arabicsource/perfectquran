# frozen_string_literal: true

require 'rails_helper'

feature 'Browsing' do
  include JavascriptHelper

  scenario 'surah' do
    visit root_path
    click_on 'Quran'

    expect(page).to have_title 'Surahs'

    click_on 'Al-Fatihah'

    expect(page).to have_title 'Al-Fatihah'

    click_on '1'

    expect(page).to have_title 'Al-Fatihah 1'
  end
end
