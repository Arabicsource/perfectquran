# frozen_string_literal: true

require 'rails_helper'

describe 'admin/articles/show' do
  let(:article) { build_stubbed :article }
  let(:title) { "Article: #{article.title}" }

  before { assign :article, article }

  it_behaves_like 'a titled view'
end
