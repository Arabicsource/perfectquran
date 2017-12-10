# frozen_string_literal: true

require 'rails_helper'

describe 'admin/articles/edit' do
  context 'behaves like an admin view' do
    before { assign :article, build_stubbed(:article, title: 'title123') }
    it_behaves_like(
      'admin view', 'Edit Article: title123', 'admin/articles/edit'
    )
  end

  it 'has an edit article form' do
    assign :article, build_stubbed(:article)

    render

    expect(rendered).to have_css 'form#edit_article'
  end
end
