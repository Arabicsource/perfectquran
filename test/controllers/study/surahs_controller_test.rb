require 'test_helper'

class Study::SurahsControllerTest < ActionDispatch::IntegrationTest
  test 'get index' do
    get study_surahs_path
    assert_response :success
  end

  test 'get index when logged in' do
    login_as accounts(:abdullah)
    get study_surahs_path
    assert_response :success
  end

  test 'get root' do
    get root_path
    assert_response :success
  end

  test 'get study root' do
    get study_root_path
    assert_response :success
  end

  test 'get show' do
    get study_surah_path(1)
    assert_response :success
  end

  test 'get show when logged in' do
    login_as accounts(:abdullah)
    get study_surah_path(1)
    assert_response :success
  end

  test 'get show with permalink' do
    get '/al-fatihah'
    assert_response :success
  end
end
