# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Destroy a memory on an ayah', js: true do
  let(:surah) { create :surah, id: 1 }
  let(:account) { create :account }
  let(:ayah) { create :ayah, surah: surah, number: 1 }

  before do
    create :memory, ayah: ayah, account: account
    login_as account
    visit quran_ayah_path(ayah)
  end

  scenario 'successfully' do
    expect { click_on(class: 'memory') }.to change(Memory, :count).from(1).to(0)
    expect(page).to have_css 'a.button.not-memorized'
  end
end
