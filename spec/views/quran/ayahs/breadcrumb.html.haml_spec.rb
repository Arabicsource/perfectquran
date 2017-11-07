# frozen_string_literal: true

require 'rails_helper'

describe 'quran/ayahs/_breadcrumb' do
  it 'renders an Index link' do
    assign :ayah, build_stubbed(:ayah)

    render

    expect(rendered).to have_link 'Index'
  end

  it 'renders a link with the name of the surah' do
    surah = build_stubbed :surah, id: 1, transliterated_name: 'abc123'
    assign :ayah, build_stubbed(:ayah, surah: surah)

    render

    expect(rendered).to have_link 'abc123', href: '/quran/surahs/1'
  end

  it 'renders the ayah number as text' do
    surah = build_stubbed :surah, id: 1
    assign :ayah, build_stubbed(:ayah, surah: surah)

    render

    expect(rendered).to have_text '1'
  end
end
