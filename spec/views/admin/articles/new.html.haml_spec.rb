# frozen_string_literal: true

require 'rails_helper'

describe 'admin/articles/new' do
  let(:article) { build_stubbed :article }
  let(:title) { 'New Article' }

  before { assign :article, article }

  it_behaves_like 'a titled view'
end
