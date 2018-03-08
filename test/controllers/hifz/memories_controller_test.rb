require 'test_helper'

module Hifz
  class MemoriesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @juz = juzs(:juz_1)
      @url = hifz_juz_memory_path(@juz)
    end

    test 'create memories without account' do
      post @url

      assert_redirected_to hifz_juzs_path
      follow_redirect!
      assert_select '.notification', text: /You must be logged in to record memories/
    end
  
    test 'create memories with account' do
      login_as accounts(:abdullah)

      assert_difference 'Memory.count', 148 do
        post @url
      end

      assert_redirected_to hifz_juzs_path
      follow_redirect!
      assert_select '.notification', text: /Alhamdulillah/
    end
  end
end
