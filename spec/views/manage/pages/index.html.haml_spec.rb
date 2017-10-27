# frozen_string_literal: true

require 'rails_helper'

describe 'manage/pages/index' do
  before(:each) do
    params[:action] = 'index'
    @pages = FactoryGirl.build_stubbed_list(:page, 5)
  end

  it 'provides layout with a page title' do
    expect(view).to receive(:provide).with(:title, 'Pages')

    render
  end

  it 'has a level one heading' do
    render

    expect(rendered).to have_selector 'h1', text: 'Pages'
  end

  it 'has a link to new' do
    render

    expect(rendered).to have_link 'New Page', href: new_manage_page_path
  end

  it 'does not have a link to index' do
    render

    expect(rendered).not_to have_link 'Index'
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

  it 'lists all posts' do
    render

    @pages.each do |page|
      expect(rendered).to have_text page.title
    end
  end
end
