# frozen_string_literal: true

require 'test_helper'

module Hifz
  class AyahsControllerTest < ActionDispatch::IntegrationTest
    test 'get show' do
      get hifz_page_ayah_path(quran_pages(:page_1), ayahs(:ayah_2))
      assert_response :success
    end

    test 'get show with account' do
      login_as accounts(:abdullah)
      get hifz_page_ayah_path(quran_pages(:page_1), ayahs(:ayah_2))
      assert_response :success
    end
  end
end
