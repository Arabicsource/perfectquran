# frozen_string_literal: true

require 'rails_helper'

describe 'admin/menus/index' do
  let(:title) { 'Menus' }

  before { assign :menus, [] }

  it_behaves_like 'a titled view'
end
