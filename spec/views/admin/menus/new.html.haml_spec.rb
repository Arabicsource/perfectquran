# frozen_string_literal: true

require 'rails_helper'

describe 'admin/menus/new' do
  let(:title) { 'New Menu' }
  let(:menu_obj) { build_stubbed :menu }

  before do
    assign :menu, menu_obj
  end

  it_behaves_like 'a titled view'
end
