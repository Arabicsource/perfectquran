# frozen_string_literal: true

require 'rails_helper'

describe 'quran/surahs/_masthead' do
  it 'has a masthead section' do
    render

    expect(rendered).to have_css 'section#masthead'
  end

  it 'has an image' do
    render

    expect(rendered).to have_css 'img.masthead-image'
  end
end
