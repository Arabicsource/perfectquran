# frozen_string_literal: true

require 'test_helper'

module Admin
  class TagsControllerTest < ActionDispatch::IntegrationTest
    test 'get index without account' do
      get admin_tags_path
      assert_redirected_to new_account_session_path
    end

    test 'get index with member account' do
      login_as accounts(:abdurrahman)
      get admin_tags_path
      assert_redirected_to root_path
    end

    test 'get index with admin account' do
      login_as accounts(:abdullah)
      get admin_tags_path
      assert_response :success
    end
  end
end
