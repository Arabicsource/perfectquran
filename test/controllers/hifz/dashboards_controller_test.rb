# frozen_string_literal: true

require 'test_helper'

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test 'get show' do
    get hifz_root_url
    assert_response :success
  end

  test 'get show with account' do
    login_as accounts(:abdullah)
    get hifz_root_url
    assert_response :success
  end
end
