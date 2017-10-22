# frozen_string_literal: true

require 'rails_helper'

describe 'quran/surahs/index' do
  before(:each) do
    @surahs = Quran::Surah.all
  end

  it 'provides layout with a page title' do
    expect(view).to receive(:provide).with(:title, 'Suwar')

    render
  end

  it 'has a level one heading' do
    render

    expect(rendered).to have_selector 'h1', text: 'Suwar'
  end

  it 'lists each surah' do
    render

    expect(rendered).to have_css 'ol#suwar-index'
    expect(rendered).to have_css 'li.surah', count: 114
    expect(rendered).to have_link '1 Al-Fatihah', href: '/quran/surahs/1'
    expect(rendered).to have_link '114 An-Nas', href: '/quran/surahs/114'
  end
end
