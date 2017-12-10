# frozen_string_literal: true

require 'rails_helper'

describe 'admin/categories/show' do
  context 'behaves like an admin view' do
    let(:category) { create :category, name: 'name123' }
    before { assign :category, category }

    it_behaves_like 'admin view', 'Category: name123', 'admin/categories/show'
  end
end
