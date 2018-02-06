# frozen_string_literal: true

require 'rails_helper'

describe '/content/articles/show', type: :request do
  context 'with published article' do
    let(:published_article) do
      create(
        :article,
        visibility: :published,
        title: 'published title',
        content: 'published content'
      )
    end

    before { get content_article_path(published_article.permalink) }

    specify { expect(response).to be_successful }
    specify { expect(response.body).to include 'published title' }
    specify { expect(response.body).to include 'published content' }
  end

  context 'with draft article' do
    let(:draft_article) { create :article, visibility: :draft }
    let(:url) { content_article_path(draft_article.permalink) }

    specify do
      expect { get url }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  context 'with trash article' do
    let(:trash_article) { create :article, visibility: :trash }
    let(:url) { content_article_path(trash_article.permalink) }

    specify do
      expect { get url }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  context 'when mobile' do
    before do
      mobile_browser
      get content_articles_path
    end

    specify { expect(response).to be_successful }
  end
end
