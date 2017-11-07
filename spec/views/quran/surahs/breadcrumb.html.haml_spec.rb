# frozen_string_literal: true

require 'rails_helper'

describe 'quran/surahs/_breadcrumb' do
  it 'renders an Index link' do
    assign :surah, build_stubbed(:surah)

    render

    expect(rendered).to have_link 'Index'
  end

  it 'renders the surahs transliterated name' do
    assign :surah, build_stubbed(:surah, transliterated_name: 'abc123')

    render

    expect(rendered).to have_text 'abc123'
  end
end
