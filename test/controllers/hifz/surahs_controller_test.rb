# frozen_string_literal: true

require 'test_helper'

module Hifz
  class SurahsControllerTest < ActionDispatch::IntegrationTest
    test 'get index' do
      get hifz_surahs_url
      assert_response :success
    end

    test 'get index with account' do
      login_as accounts(:abdullah)
      get hifz_surahs_url
      assert_response :success
    end
  end
end
