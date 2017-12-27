# frozen_string_literal: true

require 'rails_helper'

describe 'admin/categories/new' do
  let(:category) { build_stubbed :category }
  let(:title) { 'New Category' }

  before { assign :category, category }

  it_behaves_like 'a titled view'
end
