# frozen_string_literal: true

require 'rails_helper'

describe 'admin/articles/show' do
  context 'behaves like an admin view' do
    let(:article) { create :article, title: 'title123' }
    before { assign :article, article }

    it_behaves_like 'admin view', 'Article: title123', 'admin/articles/show'
  end
end
