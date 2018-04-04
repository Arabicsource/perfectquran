# frozen_string_literal: true

require 'test_helper'

module Content
  class ArticlesControllerTest < ActionDispatch::IntegrationTest
    test 'get index without account' do
      get content_articles_path
      assert_response :success
    end

    test 'get index with account' do
      login_as accounts(:abdullah)
      get content_articles_path
      assert_response :success
    end

    test 'get show' do
      get content_article_path(article.permalink)
      assert_response :success
    end

    test 'get show when draft' do
      draft = FactoryBot.create(:article, :as_draft)

      assert_raises ActiveRecord::RecordNotFound do
        get content_article_path(draft.permalink)
      end
    end

    test 'get show when trash' do
      trash = FactoryBot.create(:article, :as_trash)

      assert_raises ActiveRecord::RecordNotFound do
        get content_article_path(trash.permalink)
      end
    end

    test 'get show when logged in' do
      login_as accounts(:abdullah)
      get content_article_path(article.permalink)
      assert_response :success
    end

    private

    def article
      @article ||= FactoryBot.create :article
    end
  end
end
