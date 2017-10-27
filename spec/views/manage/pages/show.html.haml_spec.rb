# frozen_string_literal: true

require 'rails_helper'

describe 'manage/pages/show' do
  before(:each) do
    params[:action] = 'show'
    @page = FactoryBot.build_stubbed(:page)
  end

  it 'provides layout with a page title' do
    expect(view).to receive(:provide).with(:title, @page.title)

    render
  end

  it 'has a level one heading' do
    render

    expect(rendered).to have_selector 'h1', text: @page.title
  end

  it 'has a link to new' do
    render

    expect(rendered).to have_link 'New Page', href: new_manage_page_path
  end

  it 'has a link to index' do
    render

    expect(rendered).to have_link 'Index', href: manage_pages_path
  end

  it 'does not have a link to show' do
    render

    expect(rendered).not_to have_link 'Show'
  end

  it 'has a link to edit' do
    render

    expect(rendered).to have_link 'Edit', href: edit_manage_page_path(@page)
  end

  it 'has a link to destroy' do
    render

    expect(rendered).to have_link 'Delete', href: manage_page_path(@page)
  end

  it 'displays the page content' do
    render

    expect(rendered).to have_text @page.content
  end
end
