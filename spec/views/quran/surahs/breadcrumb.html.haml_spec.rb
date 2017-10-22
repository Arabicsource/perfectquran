# frozen_string_literal: true

require 'rails_helper'

describe 'quran/surahs/_breadcrumb' do
  it 'renders an Index link' do
    @surah = Quran::Surah.first

    render

    expect(rendered).to have_link 'Index'
  end

  it 'renders the surahs transliterated name' do
    @surah = Quran::Surah.first

    render

    expect(rendered).to have_text 'Al-Fatihah'
  end
end
