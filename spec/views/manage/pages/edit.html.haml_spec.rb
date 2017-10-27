# frozen_string_literal: true

require 'rails_helper'

describe 'manage/pages/edit' do
  before(:each) do
    params[:action] = 'edit'
    @page = FactoryBot.build_stubbed(:page)
  end

  it 'provides layout with a page title' do
    expect(view).to receive(:provide).with(:title, 'Edit Page')

    render
  end

  it 'has a level one heading' do
    render

    expect(rendered).to have_selector 'h1', text: 'Edit Page'
  end

  it 'has a link to new' do
    render

    expect(rendered).to have_link 'New Page', href: new_manage_page_path
  end

  it 'has a link to index' do
    render

    expect(rendered).to have_link 'Index', href: manage_pages_path
  end

  it 'has a link to show' do
    render

    expect(rendered).to have_link 'Show', href: manage_page_path(@page)
  end

  it 'does not have a link to edit' do
    render

    expect(rendered).not_to have_link 'Edit'
  end

  it 'has a link to destroy' do
    render

    expect(rendered).to have_link 'Delete', href: manage_page_path(@page)
  end

  it 'has a form' do
    render

    expect(rendered).to have_selector 'form#edit-page'
  end
end
