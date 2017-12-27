# frozen_string_literal: true

require 'rails_helper'

describe 'admin/articles/edit' do
  let(:article) { build_stubbed :article, title: 'title123' }
  let(:title) { "Edit Article: #{article.title}" }

  before { assign :article, article }

  it_behaves_like 'a titled view'
end
