# frozen_string_literal: true

require 'test_helper'

class Account
  class CardsControllerTest < ActionDispatch::IntegrationTest
    test 'get edit without account' do
      get edit_account_card_path
      assert_redirected_to new_account_session_path
    end

    test 'get edit with account' do
      login_as accounts(:abdullah)
      get edit_account_card_path
      assert_response :success
    end
  end
end
