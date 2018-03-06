require 'test_helper'

class Study::AyahsControllerTest < ActionDispatch::IntegrationTest
  test 'get show' do
    get study_ayah_path(1)
    assert_response :success
  end

  test 'get show when logged in' do
    login_as accounts(:abdullah)
    get study_ayah_path(1)
    assert_response :success
  end

  test 'get show by reference' do
    get '/1/1'
    assert_response :success
  end
end
