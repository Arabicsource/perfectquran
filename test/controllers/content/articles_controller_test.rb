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
      get content_article_path('one')
      assert_response :success
    end

    test 'get show when draft' do
      draft = articles(:draft)

      assert_raises ActiveRecord::RecordNotFound do
        get content_article_path(draft.permalink)
      end
    end

    test 'get show when trash' do
      trash = articles(:trash)

      assert_raises ActiveRecord::RecordNotFound do
        get content_article_path(trash.permalink)
      end
    end

    test 'get show when logged in' do
      login_as accounts(:abdullah)
      get content_article_path('one')
      assert_response :success
    end
  end
end
