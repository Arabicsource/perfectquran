# frozen_string_literal: true

require 'rails_helper'

describe 'content/articles/index' do
  include Devise::Test::ControllerHelpers

  it 'provides a page title' do
    assign :articles, []

    expect(view).to receive(:provide).with(:title, 'Blog')

    render
  end

  it 'has a level one heading' do
    assign :articles, []

    render

    expect(rendered).to have_selector 'h1', text: 'Blog'
  end

  it 'has a newsletter signup section' do
    allow(view).to receive(:params).and_return(controller: 'content')
    assign :articles, []

    render template: '/content/articles/index', layout: 'layouts/application'

    expect(rendered).to have_css 'section#newsletter'
  end

  it 'has headings with each article title' do
    articles = [
      create(:article, title: 'title123', visibility: 'published'),
      create(:article, title: 'title456', visibility: 'published'),
      create(:article, title: 'title789', visibility: 'published')
    ]
    assign :articles, articles

    render

    expect(rendered).to have_selector 'h1', text: 'title123'
    expect(rendered).to have_selector 'h1', text: 'title456'
    expect(rendered).to have_selector 'h1', text: 'title789'
  end

  it 'displays content for each article' do
    articles = [
      create(:article, content: 'content123', visibility: 'published'),
      create(:article, content: 'content456', visibility: 'published'),
      create(:article, content: 'content789', visibility: 'published')
    ]
    assign :articles, articles

    render

    expect(rendered).to have_content 'content123'
    expect(rendered).to have_content 'content456'
    expect(rendered).to have_content 'content789'
  end
end
