# frozen_string_literal: true

require 'rails_helper'

describe 'admin/menu_links/new' do
  context 'behaves like an admin view' do
    before do
      assign :menu, build_stubbed(:menu)
      assign :menu_link, build_stubbed(:menu_link)
    end

    it_behaves_like 'admin view', 'New Menu Link', 'admin/menu_links/new'
  end
end
