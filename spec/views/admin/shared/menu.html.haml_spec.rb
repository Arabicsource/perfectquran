# frozen_string_literal: true

require 'rails_helper'

describe 'admin/shared/_menu' do
  it 'has an nav element' do
    render

    expect(rendered).to have_css 'nav.menu'
  end

  it 'has a general label' do
    render

    expect(rendered).to have_css 'p.menu-label', text: 'General'
  end

  it 'has a content label' do
    render

    expect(rendered).to have_css 'p.menu-label', text: 'Content'
  end

  it 'has a link to the dashboard' do
    render

    expect(rendered).to have_link 'Dashboard', href: admin_root_path
  end

  it 'has a link to new article' do
    render

    expect(rendered).to have_link 'New Article', href: new_admin_article_path
  end

  it 'has a link to articles' do
    render

    expect(rendered).to have_link 'Articles', href: admin_articles_path
  end

  it 'has a link to menus' do
    render

    expect(rendered).to have_link 'Menus', href: admin_menus_path
  end
end
