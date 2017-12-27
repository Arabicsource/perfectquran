# frozen_string_literal: true

require 'rails_helper'

describe 'admin/categories/edit' do
  let(:category) { build_stubbed :category }
  let(:title) { "Edit Category: #{category.name}" }

  before { assign :category, category }

  it_behaves_like 'a titled view'
end
