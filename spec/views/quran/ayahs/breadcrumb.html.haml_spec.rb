# frozen_string_literal: true

require 'rails_helper'

describe 'quran/ayahs/_breadcrumb' do
  it 'renders an Index link' do
    @ayah = Quran::Ayah.first

    render

    expect(rendered).to have_link 'Index'
  end

  it 'renders a link with the name of the surah' do
    @ayah = Quran::Ayah.first

    render

    expect(rendered).to have_link 'Al-Fatihah', href: '/quran/surahs/1'
  end

  it 'renders the ayah number as text' do
    @ayah = Quran::Ayah.first

    render

    expect(rendered).to have_text '1'
  end
end
