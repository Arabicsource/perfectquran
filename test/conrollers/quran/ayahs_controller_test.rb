require 'test_helper'

class Quran::AyahsControllerTest < ActionDispatch::IntegrationTest
  test 'get show' do
    get quran_ayah_path(1)
    assert_response :success
  end

  test 'get show on mobile' do
    mobile_browser
    get quran_ayah_path(1)
    assert_response :success
  end
end
