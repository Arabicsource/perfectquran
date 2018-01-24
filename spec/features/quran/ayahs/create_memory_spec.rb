# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers

feature 'Create a memory on an ayah', js: true do
  let(:surah) { create :surah, id: 1 }
  let(:account) { create :account }
  let(:ayah) { create :ayah, surah: surah }

  before do
    login_as account
    visit quran_ayah_path(ayah)
  end

  scenario 'successfully' do
    expect { click_on(class: 'memory') }.to change(Memory, :count).from(0).to(1)
    expect(page).to have_css 'a.button.is-danger.memory'
  end
end
