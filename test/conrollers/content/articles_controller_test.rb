require 'test_helper'

class Content::ArticlesControllerTest < ActionDispatch::IntegrationTest
  test 'get index without account' do
    get content_articles_path
    assert_response :success
  end

  test 'get index with account' do
    login_as accounts(:abdullah)
    get content_articles_path
    assert_response :success
  end

  test 'get index without account on mobile' do
    mobile_browser
    get content_articles_path
    assert_response :success
  end

  test 'get index with account on mobile' do
    login_as accounts(:abdullah)
    mobile_browser
    get content_articles_path
    assert_response :success
  end
end
