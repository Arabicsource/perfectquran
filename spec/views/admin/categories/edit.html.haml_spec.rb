# frozen_string_literal: true

require 'rails_helper'

describe 'admin/categories/edit' do
  context 'behaves like an admin view' do
    before { assign :category, build_stubbed(:category, name: 'name123') }
    it_behaves_like(
      'admin view', 'Edit Category: name123', 'admin/categories/edit'
    )
  end
end
