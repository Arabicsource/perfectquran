# frozen_string_literal: true

require 'test_helper'

class Account
  class QuranPreferencesControllerTest < ActionDispatch::IntegrationTest
    test 'get edit without account' do
      get edit_account_quran_preference_path
      assert_redirected_to new_account_session_path
    end

    test 'get edit with account without translations' do
      login_as FactoryBot.create :account
      get edit_account_quran_preference_path
      assert_response :success
    end

    test 'get edit with account with translations' do
      login_as FactoryBot.create :account
      get edit_account_quran_preference_path
      assert_response :success
    end
  end
end
