require 'test_helper'

class Quran::SurahsControllerTest < ActionDispatch::IntegrationTest
  test 'get index' do
    get quran_surahs_path
    assert_response :success
  end
end
