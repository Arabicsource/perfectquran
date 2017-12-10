# frozen_string_literal: true

require 'rails_helper'

describe 'admin/menus/new' do
  context 'behaves like an admin view' do
    before { assign :menu, build_stubbed(:menu) }

    it_behaves_like 'admin view', 'New Menu', 'admin/menus/new'
  end

  it 'has a new form' do
    assign :menu, build_stubbed(:menu)

    render

    expect(rendered).to have_css 'form#new_menu'
  end

  it 'has a name input' do
    assign :menu, build_stubbed(:menu)

    render

    expect(rendered).to have_css 'input#menu_name'
  end

  it 'has a name input' do
    assign :menu, build_stubbed(:menu)

    render

    expect(rendered).to have_css 'input#menu_description'
  end

  it 'has a name input' do
    assign :menu, build_stubbed(:menu)

    render

    expect(rendered).to have_css 'input[type=submit][value="Save Menu"]'
  end
end
