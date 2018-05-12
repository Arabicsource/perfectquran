# frozen_string_literal: true

require 'rails_helper'

feature 'Browsing' do
  include JavascriptHelper

  xscenario 'surah' do
    visit quran_root_path
    expect(page).to have_title 'Surahs'

    click_on 'Al-Fatihah'
    expect(page).to have_title 'Al-Fatihah'

    click_on 'Next Surah'
    expect(page).to have_title 'Al-Baqarah'

    click_on 'Previous'
    expect(page).to have_title 'Al-Fatihah'

    click_on 'Previous'
    expect(page).to have_title 'An-Nas'

    click_on 'Next Surah'
    expect(page).to have_title 'Al-Fatihah'

    click_on '1'
    expect(page).to have_title 'Al-Fatihah 1'

    click_on 'Next Ayah'
    expect(page).to have_title 'Al-Fatihah 2'

    click_on 'Previous'
    expect(page).to have_title 'Al-Fatihah 1'

    click_on 'Previous'
    expect(page).to have_title 'An-Nas 6'

    click_on 'Next Ayah'
    expect(page).to have_title 'Al-Fatihah 1'

    click_on '(1:2)'
    expect(page).to have_title 'Al-Fatihah 2'

    click_on '(1:1)'
    expect(page).to have_title 'Al-Fatihah 1'
  end
end
