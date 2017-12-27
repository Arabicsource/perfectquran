# frozen_string_literal: true

require 'rails_helper'

describe 'admin/menu_links/new' do
  let(:title) { 'New Menu Link' }
  let(:menu_link) { build_stubbed :menu_link }
  let(:menu_obj) { build_stubbed :menu }

  before do
    assign :menu_link, menu_link
    assign :menu, menu_obj
  end

  it_behaves_like 'a titled view'
end
