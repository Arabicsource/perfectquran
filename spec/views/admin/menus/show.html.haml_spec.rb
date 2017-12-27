# frozen_string_literal: true

require 'rails_helper'

describe 'admin/menus/show' do
  let(:menu_obj) { build_stubbed :menu }
  let(:title) { "Menu: #{menu_obj.name}" }

  before { assign :menu, menu_obj }

  it_behaves_like 'a titled view'
end
