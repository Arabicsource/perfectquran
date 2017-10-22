# frozen_string_literal: true

require 'rails_helper'

describe 'quran/ayahs/show' do
  include Devise::Test::ControllerHelpers

  before(:each) do
    @ayah = Quran::Ayah.first
  end

  it 'provides layout with a page title' do
    expect(view).to receive(:provide).with(:title, 'Al-Fatihah 1')

    render
  end

  it 'has a level one heading' do
    render

    expect(rendered).to have_selector 'h1', text: 'Al-Fatihah 1'
  end

  it 'has a previous link' do
    render

    expect(rendered).to have_link 'Previous', href: '/quran/ayahs/6236'
  end

  it 'has a next link' do
    render

    expect(rendered).to have_link 'Next', href: '/quran/ayahs/2'
  end

  it 'has previous ayah' do
    render

    expect(rendered).to have_css '.previous-ayah'
    expect(rendered).to have_text 'Of jinns and me'
    expect(rendered).to have_link '(114:6)', href: '/quran/ayahs/6236'
  end

  it 'has next ayah' do
    render

    expect(rendered).to have_css '.next-ayah'
    expect(rendered).to have_text 'All the praises and thanks'
    expect(rendered).to have_link '(1:2)', href: '/quran/ayahs/2'
  end

  it 'has current ayah' do
    render

    expect(rendered).to have_css '.current-ayah'
    expect(rendered).to have_text 'In the Name of Allah'
  end
end
