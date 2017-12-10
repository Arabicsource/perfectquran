# frozen_string_literal: true

require 'rails_helper'

describe 'admin/menus/edit' do
  context 'behaves like an admin view' do
    before { assign :menu, build_stubbed(:menu, name: 'name123') }
    it_behaves_like(
      'admin view', 'Edit Menu: name123', 'admin/menus/edit'
    )
  end

  it 'has an edit form' do
    assign :menu, build_stubbed(:menu)

    render

    expect(rendered).to have_css 'form#edit_menu'
  end

  it 'has a name input' do
    assign :menu, build_stubbed(:menu)

    render

    expect(rendered).to have_css 'input#menu_name'
  end

  it 'has a description input' do
    assign :menu, build_stubbed(:menu)

    render

    expect(rendered).to have_css 'input#menu_description'
  end

  it 'has a submit input' do
    assign :menu, build_stubbed(:menu)

    render

    expect(rendered).to have_css 'input[type=submit][value="Save Menu"]'
  end
end
