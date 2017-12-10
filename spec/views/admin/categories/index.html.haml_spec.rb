# frozen_string_literal: true

require 'rails_helper'

describe 'admin/categories/index' do
  context 'behaves like an admin view' do
    before { assign :categories, [] }
    it_behaves_like 'admin view', 'Categories', 'admin/categories/index'
  end
end
