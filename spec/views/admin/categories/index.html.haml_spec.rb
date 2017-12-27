# frozen_string_literal: true

require 'rails_helper'

describe 'admin/categories/index' do
  let(:title) { 'Categories' }

  before { assign :categories, [] }

  it_behaves_like 'a titled view'
end
