# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers
include JavascriptHelper

feature 'Memorize a surah', js: true do
  scenario 'successfully' do
    surah = create :surah, id: 1
    create_list :ayah, 3, surah: surah

    login_as create(:account)
    visit quran_surah_path(surah)
    click_on 'Memory'

    expect(page).to have_css '.is-memorized', text: 'Memory'
  end
end
