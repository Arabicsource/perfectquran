# frozen_string_literal: true

require 'rails_helper'

describe 'admin/categories/new' do
  context 'behaves like an admin view' do
    before { assign :category, build_stubbed(:category) }
    it_behaves_like 'admin view', 'New Category', 'admin/categories/new'
  end
end
