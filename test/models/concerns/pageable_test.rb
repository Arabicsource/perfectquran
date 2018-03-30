# frozen_string_literal: true

require 'test_helper'

class PageableTest < ActiveSupport::TestCase
  test 'pages' do
    assert_equal [1], Quran::Surah.first.pages.map(&:id)
    assert_equal (1..21).to_a, juzs(:juz_1).pages.map(&:id)
  end

  test 'first_page' do
    assert_equal quran_pages(:page_1), Quran::Surah.first.first_page
    assert_equal quran_pages(:page_1), juzs(:juz_1).first_page
  end
end
