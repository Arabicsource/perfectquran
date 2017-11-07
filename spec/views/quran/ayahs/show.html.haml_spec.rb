# frozen_string_literal: true

require 'rails_helper'

describe 'quran/ayahs/show' do
  include Devise::Test::ControllerHelpers

  it 'provides layout with a page title' do
    surah = create :surah, transliterated_name: 'Al-Fatihah'
    assign :ayah, build_stubbed(:ayah, number: 1, surah: surah)

    expect(view).to receive(:provide).with(:title, 'Al-Fatihah 1')

    render
  end

  it 'has a level one heading' do
    surah = create :surah, transliterated_name: 'Al-Fatihah'
    assign :ayah, build_stubbed(:ayah, number: 1, surah: surah)

    render

    expect(rendered).to have_selector 'h1', text: 'Al-Fatihah 1'
  end

  it 'has a previous link' do
    create :ayah, id: 1
    current = create :ayah, id: 2

    assign :ayah, current
    render

    expect(rendered).to have_link 'Previous'
  end

  it 'has a next link' do
    current = create :ayah, id: 2
    create :ayah, id: 3

    assign :ayah, current
    render

    expect(rendered).to have_link 'Next'
  end

  it 'has previous ayah' do
    first = create :ayah, id: 1
    current = create :ayah, id: 2
    translation = create :translation, id: 3
    create :text, ayah: first, translation: translation, content: 'abc123'

    assign :ayah, current
    render

    expect(rendered).to have_css '.previous-ayah'
    expect(rendered).to have_text 'abc123'
  end

  it 'has next ayah' do
    current = create :ayah, id: 2
    third = create :ayah, id: 3
    translation = create :translation, id: 3
    create :text, ayah: third, translation: translation, content: 'abc123'

    assign :ayah, current
    render

    expect(rendered).to have_css '.next-ayah'
    expect(rendered).to have_text 'abc123'
  end

  it 'has current ayah' do
    current = create :ayah, id: 2
    translation = create :translation, id: 3
    create :text, ayah: current, translation: translation, content: 'abc123'

    assign :ayah, current
    render

    expect(rendered).to have_css '.current-ayah'
    expect(rendered).to have_text 'abc123'
  end
end
