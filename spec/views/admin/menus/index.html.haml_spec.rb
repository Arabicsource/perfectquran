# frozen_string_literal: true

require 'rails_helper'

describe 'admin/menus/index' do
  context 'behaves like an admin view' do
    before { assign :menus, [] }

    it_behaves_like 'admin view', 'Menus', 'admin/menus/index'
  end

  it 'has a link to new menu form' do
    assign :menus, []

    render

    expect(rendered).to have_link 'New Menu', href: new_admin_menu_path
  end

  it 'has a table for menus' do
    assign :menus, []

    render

    expect(rendered).to have_css 'table#menus'
  end

  it 'lists each menu name' do
    menus = [
      build_stubbed(:menu, name: 'name123'),
      build_stubbed(:menu, name: 'name456'),
      build_stubbed(:menu, name: 'name789')
    ]
    assign :menus, menus

    render

    expect(rendered).to have_selector 'td', text: 'name123'
    expect(rendered).to have_selector 'td', text: 'name456'
    expect(rendered).to have_selector 'td', text: 'name789'
  end

  it 'lists each menu description' do
    menus = [
      build_stubbed(:menu, description: 'description123'),
      build_stubbed(:menu, description: 'description456'),
      build_stubbed(:menu, description: 'description789')
    ]
    assign :menus, menus

    render

    expect(rendered).to have_selector 'td', text: 'description123'
    expect(rendered).to have_selector 'td', text: 'description456'
    expect(rendered).to have_selector 'td', text: 'description789'
  end

  it 'has a link to the menu' do
    menu = build_stubbed :menu, name: 'name123'
    assign :menus, [menu]

    render

    expect(rendered).to have_link 'name123', href: admin_menu_path(menu)
  end
end
