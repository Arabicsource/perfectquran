# frozen_string_literal: true

require 'test_helper'

module Hifz
  class PagesControllerTest < ActionDispatch::IntegrationTest
    test 'get index' do
      get hifz_pages_url
      assert_response :success
    end

    test 'get index with account' do
      login_as accounts(:abdullah)
      get hifz_pages_url
      assert_response :success
    end

    test 'get show' do
      get hifz_page_url pages(:page_1)
      assert_response :success
    end

    test 'get show with account' do
      login_as accounts(:abdullah)
      get hifz_page_url pages(:page_1)
      assert_response :success
    end
  end
end
