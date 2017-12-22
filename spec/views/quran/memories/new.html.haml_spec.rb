# frozen_string_literal: true

require 'rails_helper'

describe 'quran/memories/new' do
  it 'provides layout with a page title' do
    assign :commonly_memorized_surahs, []

    expect(view).to(
      receive(:provide).with(:title, 'Have you memorized any of these Surahs?')
    )

    render
  end

  it 'has a level one heading' do
    assign :commonly_memorized_surahs, []

    render

    expect(rendered).to(
      have_selector('h1', text: 'Have you memorized any of these Surahs?')
    )
  end
end
