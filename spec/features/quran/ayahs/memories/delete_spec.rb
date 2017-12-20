# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers
include JavascriptHelper

feature 'Forget an ayah', js: true do
  scenario 'successfully' do
    account = create :account
    surah = create :surah, id: 1
    ayah = create :ayah, surah: surah, number: 1
    create :memory, account: account, ayah: ayah

    login_as account
    visit quran_ayah_path(ayah)

    expect { click_on 'Memory' }.to change(Memory, :count).by(-1)
  end
end
