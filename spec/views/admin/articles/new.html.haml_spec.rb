# frozen_string_literal: true

require 'rails_helper'

describe 'admin/articles/new' do
  context 'behaves like an admin view' do
    before { assign :article, build_stubbed(:article) }
    it_behaves_like 'admin view', 'New Article', 'admin/articles/new'
  end

  it 'has a new article form' do
    assign :article, build_stubbed(:article)

    render

    expect(rendered).to have_css 'form#new_article'
  end
end
