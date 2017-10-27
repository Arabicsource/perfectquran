# frozen_string_literal: true

require 'rails_helper'

describe 'manage/pages/new' do
  before(:each) do
    params[:action] = 'new'
    @page = FactoryGirl.build_stubbed(:page)
    allow(@page).to receive(:persisted?).and_return(false)
  end

  it 'provides layout with a page title' do
    expect(view).to receive(:provide).with(:title, 'New Page')

    render
  end

  it 'has a level one heading' do
    render

    expect(rendered).to have_selector 'h1', text: 'New Page'
  end

  it 'does not have a link to new' do
    render

    expect(rendered).not_to have_link 'New Page'
  end

  it 'has a link to index' do
    render

    expect(rendered).to have_link 'Index', href: manage_pages_path
  end

  it 'does not have a link to show' do
    render

    expect(rendered).not_to have_link 'Show'
  end

  it 'does not have a link to edit' do
    render

    expect(rendered).not_to have_link 'Edit'
  end

  it 'does not have a link to destroy' do
    render

    expect(rendered).not_to have_link 'Delete'
  end

  it 'has a new page form' do
    render

    expect(rendered).to have_selector 'form#new-page'
  end
end
