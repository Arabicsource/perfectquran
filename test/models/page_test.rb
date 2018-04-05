# frozen_string_literal: true

require 'test_helper'

class PageTest < ActiveSupport::TestCase
  test 'previous' do
    assert_equal quran_pages(:page_2).previous, quran_pages(:page_1)
  end

  test 'previous when first' do
    assert_equal quran_pages(:page_1).previous, quran_pages(:page_604)
  end

  test 'previous when last' do
    assert_equal quran_pages(:page_604).previous, quran_pages(:page_603)
  end

  test 'next' do
    assert_equal quran_pages(:page_2).next, quran_pages(:page_3)
  end

  test 'next when first' do
    assert_equal quran_pages(:page_1).next, quran_pages(:page_2)
  end

  test 'next when last' do
    assert_equal quran_pages(:page_604).next, quran_pages(:page_1)
  end

  test 'description' do
    skip
    surah = surahs(:surah_1)
    assert_equal 'The Opening - الفاتحة', surah.description
  end

  test 'to_s' do
    page = quran_pages(:page_1)
    assert_equal 'Page 1', page.to_s
  end
end
