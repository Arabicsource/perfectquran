# frozen_string_literal: true

require 'test_helper'

class Account
  class ChargesControllerTest < ActionDispatch::IntegrationTest
    test 'get index without account' do
      get account_charges_path
      assert_redirected_to new_account_session_path
    end

    test 'get index with account' do
      login_as accounts(:abdullah)
      get account_charges_path
      assert_response :success
    end
  end
end
