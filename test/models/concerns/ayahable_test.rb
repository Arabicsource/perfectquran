# frozen_string_literal: true

require 'test_helper'

class AyahableTest < ActiveSupport::TestCase
  test 'ayahs' do
    assert_equal (1..7).to_a, quran_pages(:page_1).ayahs.map(&:id)
    assert_equal (1..7).to_a, surahs(:surah_1).ayahs.map(&:id)
    assert_equal (1..148).to_a, juzs(:juz_1).ayahs.map(&:id)
  end

  test 'first_ayah' do
    assert_equal ayahs(:ayah_1), quran_pages(:page_1).first_ayah
    assert_equal ayahs(:ayah_8), quran_pages(:page_2).first_ayah

    assert_equal ayahs(:ayah_1), surahs(:surah_1).first_ayah
    assert_equal ayahs(:ayah_8), surahs(:surah_2).first_ayah

    assert_equal ayahs(:ayah_1), juzs(:juz_1).first_ayah
    assert_equal ayahs(:ayah_149), juzs(:juz_2).first_ayah
  end

  test 'current_ayah' do
    assert_equal ayahs(:ayah_1), quran_pages(:page_1).current_ayah

    quran_pages(:page_1).current_ayah = ayahs(:ayah_2)
    assert_equal ayahs(:ayah_2), quran_pages(:page_1).current_ayah

    quran_pages(:page_1).current_ayah = ayahs(:ayah_8)
    assert_equal ayahs(:ayah_1), quran_pages(:page_1).current_ayah
  end

  test 'current_ayah?' do
    assert quran_pages(:page_1).current_ayah?(ayahs(:ayah_1))
    assert_not quran_pages(:page_1).current_ayah?(ayahs(:ayah_2))

    quran_pages(:page_1).current_ayah = ayahs(:ayah_2)
    assert_not quran_pages(:page_1).current_ayah?(ayahs(:ayah_1))
    assert quran_pages(:page_1).current_ayah?(ayahs(:ayah_2))
  end

  test 'previous_ayah' do
    assert_equal ayahs(:ayah_7), quran_pages(:page_1).previous_ayah

    quran_pages(:page_1).current_ayah = ayahs(:ayah_7)
    assert_equal ayahs(:ayah_6), quran_pages(:page_1).previous_ayah

    quran_pages(:page_1).current_ayah = ayahs(:ayah_3)
    assert_equal ayahs(:ayah_2), quran_pages(:page_1).previous_ayah
  end

  test 'previous_ayah?' do
    assert_not quran_pages(:page_1).previous_ayah?

    quran_pages(:page_1).current_ayah = ayahs(:ayah_7)
    assert quran_pages(:page_1).previous_ayah?

    quran_pages(:page_1).current_ayah = ayahs(:ayah_3)
    assert quran_pages(:page_1).previous_ayah?
  end

  test 'last_ayah' do
    assert_equal ayahs(:ayah_7), quran_pages(:page_1).last_ayah
    assert_equal ayahs(:ayah_12), quran_pages(:page_2).last_ayah

    assert_equal ayahs(:ayah_7), surahs(:surah_1).last_ayah
    assert_equal ayahs(:ayah_293), surahs(:surah_2).last_ayah

    assert_equal ayahs(:ayah_148), juzs(:juz_1).last_ayah
    assert_equal ayahs(:ayah_259), juzs(:juz_2).last_ayah
  end

  test 'next_ayah' do
    assert_equal ayahs(:ayah_2), quran_pages(:page_1).next_ayah

    quran_pages(:page_1).current_ayah = ayahs(:ayah_7)
    assert_equal ayahs(:ayah_1), quran_pages(:page_1).next_ayah

    quran_pages(:page_1).current_ayah = ayahs(:ayah_3)
    assert_equal ayahs(:ayah_4), quran_pages(:page_1).next_ayah
  end

  test 'next_ayah?' do
    assert quran_pages(:page_1).next_ayah?

    quran_pages(:page_1).current_ayah = ayahs(:ayah_7)
    assert_not quran_pages(:page_1).next_ayah?

    quran_pages(:page_1).current_ayah = ayahs(:ayah_3)
    assert quran_pages(:page_1).next_ayah?
  end
end
