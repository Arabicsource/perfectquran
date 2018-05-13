# frozen_string_literal: true

require 'rails_helper'

feature 'Bookmarking', js: true do
  let(:member) { create :member }

  scenario 'creating' do
    login_as member
    visit quran_surah_path(quran_surahs(:surah_1))

    within '#ayah-1' do
      click_on 'Bookmark'
      expect(page).to have_css 'a.bookmark.active'
    end
  end

  scenario 'deleting' do
    login_as member
    create :bookmark, account: member, ayah: Quran::Ayah.first
    visit quran_surah_path(quran_surahs(:surah_1))

    within '#ayah-1' do
      click_on 'Bookmarked'
      expect(page).to have_css 'a.bookmark'
      expect(page).to_not have_css 'a.bookmark.active'
    end
  end
end
