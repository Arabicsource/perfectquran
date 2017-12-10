# frozen_string_literal: true

require 'rails_helper'

describe 'admin/menus/show' do
  context 'behaves like an admin view' do
    let(:menu) { create :menu, name: 'name123' }
    before { assign :menu, menu }

    it_behaves_like 'admin view', 'Menu: name123', 'admin/menus/show'
  end

  it 'has a link to the edit action' do
    menu = create :menu
    assign :menu, menu

    render

    expect(rendered).to have_link 'Edit', href: edit_admin_menu_path(menu)
  end
end
