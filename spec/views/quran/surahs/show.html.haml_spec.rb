# frozen_string_literal: true

require 'rails_helper'

describe 'quran/surahs/show' do
  before(:each) do
    @surah = Quran::Surah.first
  end

  it 'provides layout with a page title' do
    expect(view).to receive(:provide).with(:title, 'Al-Fatihah')

    render
  end

  it 'has a level one heading' do
    render

    expect(rendered).to have_selector 'h1', text: 'Al-Fatihah'
  end

  it 'lists each ayah' do
    render

    expect(rendered).to have_css 'article#surah'
    expect(rendered).to have_css 'article.ayah', count: 7
    expect(rendered).to have_link 'Al-Fatihah 1'
    expect(rendered).to have_link 'Al-Fatihah 2'
    expect(rendered).to have_link 'Al-Fatihah 3'
    expect(rendered).to have_link 'Al-Fatihah 4'
    expect(rendered).to have_link 'Al-Fatihah 5'
    expect(rendered).to have_link 'Al-Fatihah 6'
    expect(rendered).to have_link 'Al-Fatihah 7'
  end
end
