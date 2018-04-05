# frozen_string_literal: true

require 'test_helper'

class Account
  class ProfilesControllerTest < ActionDispatch::IntegrationTest
    test 'get edit without account' do
      get edit_account_profile_path
      assert_redirected_to new_account_session_path
    end

    test 'get edit with account' do
      login_as FactoryBot.create :account
      get edit_account_profile_path
      assert_response :success
    end
  end
end
