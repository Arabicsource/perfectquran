require 'test_helper'

class Study::AyahsControllerTest < ActionDispatch::IntegrationTest
  test 'get index as json' do
    get '/study/ayahs.json'
    assert_response :success
  end

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

  test 'get show as json' do
    get '/study/ayahs/1.json'
    assert_response :success
  end
end