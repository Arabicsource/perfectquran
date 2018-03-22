 # frozen_string_literal: true

require 'test_helper'

class Account
  class QuranPreferencesControllerTest < ActionDispatch::IntegrationTest
    test 'get edit without account' do
      get edit_account_quran_preference_path
      assert_redirected_to new_account_session_path
    end

    test 'get edit with account' do
      login_as accounts(:abdullah)
      get edit_account_quran_preference_path
      assert_response :success
    end
  end
end
