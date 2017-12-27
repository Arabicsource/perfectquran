# frozen_string_literal: true

require 'rails_helper'

describe 'admin/menu_links/edit' do
  let(:menu_obj) { build_stubbed :menu }
  let(:menu_link) { build_stubbed :menu_link }
  let(:title) { "Edit Menu Link: #{menu_link.name}" }

  before do
    assign :menu, menu_obj
    assign :menu_link, menu_link
  end

  it_behaves_like 'a titled view'
end
