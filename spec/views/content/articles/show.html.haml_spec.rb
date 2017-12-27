# frozen_string_literal: true

require 'rails_helper'

describe 'content/articles/show' do
  context 'as either' do
    let(:article) { build_stubbed :article }
    let(:title) { article.title }

    before do
      allow(view).to receive(:account_signed_in?).and_return(false)
      assign :article, article
    end

    it_behaves_like 'a titled view'

    it 'has content' do
      render

      expect(rendered).to have_content article.content
    end
  end

  context 'as a page' do
    let(:article) { build_stubbed :article, collection: 'page' }

    before { assign :article, article }

    context 'when logged in' do
      before { allow(view).to receive(:account_signed_in?).and_return(true) }

      it 'does not have a new comment section' do
        render

        expect(rendered).not_to have_css 'section#new-comment'
      end
    end
  end

  context 'as a post' do
    let(:article) { build_stubbed :article, collection: 'post' }
    let(:comment) { build :comment }

    before do
      assign :article, article
      assign :comment, comment
    end

    context 'with comments' do
      before do
        allow(view).to receive(:account_signed_in?).and_return(false)
        allow(article.comments).to receive(:any?).and_return(true)
      end

      it 'has comments section' do
        render

        expect(rendered).to have_css 'section#comments'
      end
    end

    context 'when logged in' do
      before { allow(view).to receive(:account_signed_in?).and_return(true) }

      it 'has a new comment section' do
        render

        expect(rendered).to have_css 'section#new-comment'
      end
    end

    context 'when not logged in' do
      before { allow(view).to receive(:account_signed_in?).and_return(false) }

      it 'does not a new comment section' do
        render

        expect(rendered).not_to have_css 'section#new-comment'
      end
    end
  end
end
