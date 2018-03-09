# frozen_string_literal: true

require 'test_helper'

module Hifz
  class JuzsControllerTest < ActionDispatch::IntegrationTest
    test 'get show' do
      get hifz_juzs_url
      assert_response :success
    end

    test 'get show with account' do
      login_as accounts(:abdullah)
      get hifz_juzs_url
      assert_response :success
    end
  end
end
