# frozen_string_literal: true

require 'rails_helper'

describe 'admin/articles/index' do
  let(:title) { 'Articles' }

  before { assign :articles, [] }

  it_behaves_like 'a titled view'
end
