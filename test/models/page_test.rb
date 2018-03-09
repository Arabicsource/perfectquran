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

  test 'next' do
    assert_equal pages(:page_2).next, pages(:page_3)
  end

  test 'next when first' do
    assert_equal pages(:page_1).next, pages(:page_2)
  end

  test 'next when last' do
    assert_equal pages(:page_604).next, pages(:page_1)
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

  test 'memorized?' do
    Current.account = accounts(:abdullah)
    page = pages(:page_1)
    pm = PageMemory.create(account: Current.account, page: page, character_length: 55)
    assert_not page.memorized?

    pm.update_attribute(:character_length, page.character_length)
    assert page.memorized?
  end

  test 'memorized_percentage' do
    Current.account = accounts(:abdullah)
    assert pages(:page_1).memorized_percentage.zero?

    ayahs(:ayah_1).memorize
    assert_equal 13.333333333333334, pages(:page_1).memorized_percentage
  end

  test 'memorize' do
    Current.account = accounts(:abdullah)
    assert Current.account.memories.count.zero?

    pages(:page_1).memorize
    assert_equal 7, Current.account.memories.count
  end
end