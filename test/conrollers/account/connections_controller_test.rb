require 'test_helper'

class Account::ConnectionsControllerTest < ActionDispatch::IntegrationTest
  test 'get index without account' do
    get account_connections_path
    assert_redirected_to new_account_session_path
  end

  test 'get index with account' do
    login_as accounts(:abdullah)
    get account_connections_path
    assert_response :success
  end
end
