require 'test_helper'

class PageTest < ActiveSupport::TestCase
  test 'description' do
    skip
    surah = surahs(:surah_1)
    assert_equal 'The Opening - الفاتحة', surah.description
  end

  test 'to_s' do
    skip
    surah = surahs(:surah_1)
    assert_equal 'Al-Fatihah', surah.to_s
  end
end