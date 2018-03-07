require 'test_helper'

class PageTest < ActiveSupport::TestCase
  test 'previous' do
    assert_equal pages(:page_2).previous, pages(:page_1)
  end

  test 'previous when first' do
    assert_equal pages(:page_1).previous, pages(:page_604)
  end

  test 'previous when last' do
    assert_equal pages(:page_604).previous, pages(:page_603)
  end

  test 'description' do
    skip
    surah = surahs(:surah_1)
    assert_equal 'The Opening - الفاتحة', surah.description
  end

  test 'to_s' do
    page = pages(:page_1)
    assert_equal 'Page 1', page.to_s
  end
end