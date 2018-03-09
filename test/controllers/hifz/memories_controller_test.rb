require 'test_helper'

module Hifz
  class MemoriesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @ayah = ayahs(:ayah_1)
      @juz = juzs(:juz_1)
    end

    test 'create memory for ayah without account' do
      post hifz_ayah_memory_path(@ayah)

      follow_redirect!
      assert_select '.notification', text: /You must be logged in to record memories/
    end

    test 'create memory for ayah with account' do
      login_as accounts(:abdullah)

      assert_difference 'Memory.count', 1 do
        post hifz_ayah_memory_path(@ayah)
      end

      follow_redirect!
      assert_select '.notification', text: /Alhamdulillah/
    end

    test 'create memories for juz without account' do
      post hifz_juz_memory_path(@juz)

      follow_redirect!
      assert_select '.notification', text: /You must be logged in to record memories/
    end
  
    test 'create memories for juz with account' do
      login_as accounts(:abdullah)

      assert_difference 'Memory.count', 148 do
        post hifz_juz_memory_path(@juz)
      end

      follow_redirect!
      assert_select '.notification', text: /Alhamdulillah/
    end
  end
end
