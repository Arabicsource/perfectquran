# frozen_string_literal: true

require 'rails_helper'

describe 'content/pages/show' do
  before { @page = FactoryGirl.build_stubbed(:page) }

  it 'provides layout with a page title' do
    expect(view).to receive(:provide).with(:title, @page.title)

    render
  end

  it 'has a level one heading' do
    render

    expect(rendered).to have_selector 'h1', text: @page.title
  end

  it 'displays page content' do
    render

    expect(rendered).to have_text @page.content
  end
end
