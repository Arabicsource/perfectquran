# frozen_string_literal: true

require 'test_helper'

module Study
  class SearchControllerTest < ActionDispatch::IntegrationTest
    test 'get show' do
      get study_search_path(terms: 'Peace')
      assert_response :success
    end

    test 'get show when logged in' do
      login_as accounts(:abdullah)
      get study_search_path(terms: 'Peace')
      assert_response :success
    end

    test 'get show without terms' do
      get study_search_path
      assert_redirected_to root_url
    end

    test 'get show with empty terms' do
      get study_search_path(terms: '')
      assert_redirected_to root_url
    end
  end
end
