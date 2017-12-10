# frozen_string_literal: true

require 'rails_helper'

describe 'GET Content::Articles#show', type: :request do
  it 'responds successfully' do
    article = create :article, visibility: 'published'

    get content_article_path(article.permalink)

    expect(response).to be_successful
  end

  context 'article is a draft' do
    it 'raises and ActiveRecord::RecordNotFound expection' do
      article = create :article, visibility: 'draft'

      expect { get content_article_path(article.permalink) }
        .to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  context 'article is trash' do
    it 'raises and ActiveRecord::RecordNotFound expection' do
      article = create :article, visibility: 'trash'

      expect { get content_article_path(article.permalink) }
        .to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
