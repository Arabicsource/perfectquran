# frozen_string_literal: true

require 'test_helper'

class Account
  class ConnectionsControllerTest < ActionDispatch::IntegrationTest
    test 'get index without account' do
      get account_connections_path
      assert_redirected_to new_account_session_path
    end

    test 'get index with account' do
      login_as FactoryBot.create :account
      get account_connections_path
      assert_response :success
    end
  end
end
