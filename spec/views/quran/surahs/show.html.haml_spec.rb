# frozen_string_literal: true

require 'rails_helper'

describe 'quran/surahs/show' do
  include Devise::Test::ControllerHelpers

  it 'provides layout with a page title' do
    assign :surah, create(:surah, transliterated_name: 'abc123')

    expect(view).to receive(:provide).with(:title, 'abc123')

    render
  end

  it 'has a level one heading' do
    assign :surah, create(:surah, transliterated_name: 'abc123')

    render

    expect(rendered).to have_selector 'h1', text: 'abc123'
  end

  it 'lists each ayah' do
    surah = create :surah, transliterated_name: 'abc123'
    create :ayah, surah: surah, number: 1
    create :ayah, surah: surah, number: 2

    assign :surah, surah

    render

    expect(rendered).to have_css 'article#surah'
    expect(rendered).to have_css 'article.ayah', count: 2
    expect(rendered).to have_link 'abc123 1'
    expect(rendered).to have_link 'abc123 2'
  end
end
