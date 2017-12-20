# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers
include JavascriptHelper

feature 'Memorize an ayah', js: true do
  scenario 'successfully' do
    surah = create :surah, id: 1
    ayah = create :ayah, surah: surah, number: 1
    login_as create(:account)
    visit quran_ayah_path(ayah)

    expect { click_on 'Memory' }.to change(Memory, :count).by(1)
  end
end
