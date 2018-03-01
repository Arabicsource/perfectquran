require 'test_helper'

class Quran::SurahsControllerTest < ActionDispatch::IntegrationTest
  test 'get index' do
    get quran_surahs_path
    assert_response :success
  end

  test 'get index on mobile' do
    login_as accounts(:abdullah)
    mobile_browser
    get quran_surahs_path
    assert_response :success
  end
end
