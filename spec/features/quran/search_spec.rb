# frozen_string_literal: true

require 'rails_helper'

feature 'Searching' do
  let!(:texts) { create_list :text, 3, content: 'abc123' }

  before { Quran::Text.reindex }

  scenario 'the quran' do
    visit quran_root_path
    fill_in 'search-terms-input', with: 'abc123'
    click_on 'Search'

    expect(page).to have_text 'Your search for abc123 returned 3 results'
    expect(page).to have_css '.search-result', count: 3
  end
end
