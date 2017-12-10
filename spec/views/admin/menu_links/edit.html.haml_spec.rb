# frozen_string_literal: true

require 'rails_helper'

describe 'admin/menu_links/edit' do
  context 'behaves like an admin view' do
    before do
      menu = build_stubbed :menu
      menu_link = build_stubbed :menu_link, menu: menu, name: 'link123'
      assign :menu, menu
      assign :menu_link, menu_link
    end

    it_behaves_like(
      'admin view', 'Edit Menu Link: link123', 'admin/menu_links/edit'
    )
  end
end
