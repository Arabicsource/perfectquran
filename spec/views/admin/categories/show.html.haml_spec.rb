# frozen_string_literal: true

require 'rails_helper'

describe 'admin/categories/show' do
  let(:category) { build_stubbed :category }
  let(:title) { "Category: #{category.name}" }

  before { assign :category, category }

  it_behaves_like 'a titled view'
end
