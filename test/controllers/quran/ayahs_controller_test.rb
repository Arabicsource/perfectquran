require 'test_helper'

class Quran::AyahsControllerTest < ActionDispatch::IntegrationTest
  test 'get show' do
    get quran_ayah_path(1)
    assert_response :success
  end
end
