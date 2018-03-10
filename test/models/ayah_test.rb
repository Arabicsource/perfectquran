# frozen_string_literal: true

require 'test_helper'

class AyahTest < ActiveSupport::TestCase
  test 'uthmani_text' do
    assert_equal 'Uthmani 1', ayahs(:ayah_1).uthmani_text
  end

  test 'transliterated_text' do
    assert_equal 'Transliteration 1', ayahs(:ayah_1).transliterated_text
  end

  test 'noble_quran_text' do
    assert_equal 'Noble Quran 1', ayahs(:ayah_1).noble_quran_text
  end

  test 'surah_name' do
    assert_equal 'Al-Fatihah', ayahs(:ayah_1).surah_name
  end

  test 'previous' do
    assert_equal ayahs(:ayah_1), ayahs(:ayah_2).previous
    assert_equal ayahs(:ayah_6236), ayahs(:ayah_1).previous
  end

  test 'next' do
    assert_equal ayahs(:ayah_2), ayahs(:ayah_1).next
    assert_equal ayahs(:ayah_1), ayahs(:ayah_6236).next
  end

  test 'memorize' do
    Current.account = accounts(:abdullah)
    assert Current.account.memories.count.zero?

    ayahs(:ayah_1).memorize
    assert_equal 1, Current.account.memories.count
  end

  test 'memorized?' do
    Current.account = accounts(:abdullah)
    ayah = ayahs(:ayah_1)
    assert_not ayah.memorized?

    ayah.memorize
    assert ayah.memorized?
  end
end
