# frozen_string_literal: true

require 'rails_helper'

describe 'quran/surahs/index' do
  it 'provides layout with a page title' do
    assign :surahs, []

    expect(view).to receive(:provide).with(:title, 'Suwar')

    render
  end

  it 'has a level one heading' do
    assign :surahs, []
    render

    expect(rendered).to have_selector 'h1', text: 'Suwar'
  end

  it 'lists each surah' do
    surahs = [
      build_stubbed(:surah, id: 1, transliterated_name: 'abc123'),
      build_stubbed(:surah, id: 114, transliterated_name: '321cba')
    ]

    assign :surahs, surahs
    render

    expect(rendered).to have_css 'ol#suwar-index'
    expect(rendered).to have_css 'li.surah', count: 2
    expect(rendered).to have_link '1 abc123', href: '/quran/surahs/1'
    expect(rendered).to have_link '114 321cba', href: '/quran/surahs/114'
  end
end
