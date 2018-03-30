# frozen_string_literal: true

require 'test_helper'

class AyahableTest < ActiveSupport::TestCase
  test 'ayahs' do
    assert_equal (1..7).to_a, quran_pages(:page_1).ayahs.map(&:id)
    assert_equal (1..7).to_a, Quran::Surah.first.ayahs.map(&:id)
    assert_equal (1..148).to_a, Quran::Juz.first.ayahs.map(&:id)
  end

  test 'first_ayah' do
    assert_equal Quran::Ayah.first, quran_pages(:page_1).first_ayah
    assert_equal Quran::Ayah.find(8), quran_pages(:page_2).first_ayah

    assert_equal Quran::Ayah.first, Quran::Surah.first.first_ayah
    assert_equal Quran::Ayah.find(8), Quran::Surah.second.first_ayah

    assert_equal Quran::Ayah.first, Quran::Juz.first.first_ayah
    assert_equal Quran::Ayah.find(149), Quran::Juz.second.first_ayah
  end

  test 'current_ayah' do
    assert_equal Quran::Ayah.first, quran_pages(:page_1).current_ayah

    quran_pages(:page_1).current_ayah = Quran::Ayah.second
    assert_equal Quran::Ayah.second, quran_pages(:page_1).current_ayah

    quran_pages(:page_1).current_ayah = Quran::Ayah.find(8)
    assert_equal Quran::Ayah.first, quran_pages(:page_1).current_ayah
  end

  test 'current_ayah?' do
    assert quran_pages(:page_1).current_ayah?(Quran::Ayah.first)
    assert_not quran_pages(:page_1).current_ayah?(Quran::Ayah.second)

    quran_pages(:page_1).current_ayah = Quran::Ayah.second
    assert_not quran_pages(:page_1).current_ayah?(Quran::Ayah.first)
    assert quran_pages(:page_1).current_ayah?(Quran::Ayah.second)
  end

  test 'previous_ayah' do
    assert_equal Quran::Ayah.find(7), quran_pages(:page_1).previous_ayah

    quran_pages(:page_1).current_ayah = Quran::Ayah.find(7)
    assert_equal Quran::Ayah.find(6), quran_pages(:page_1).previous_ayah

    quran_pages(:page_1).current_ayah = Quran::Ayah.find(3)
    assert_equal Quran::Ayah.second, quran_pages(:page_1).previous_ayah
  end

  test 'previous_ayah?' do
    assert_not quran_pages(:page_1).previous_ayah?

    quran_pages(:page_1).current_ayah = Quran::Ayah.find(7)
    assert quran_pages(:page_1).previous_ayah?

    quran_pages(:page_1).current_ayah = Quran::Ayah.find(3)
    assert quran_pages(:page_1).previous_ayah?
  end

  test 'last_ayah' do
    assert_equal Quran::Ayah.find(7), quran_pages(:page_1).last_ayah
    assert_equal Quran::Ayah.find(12), quran_pages(:page_2).last_ayah

    assert_equal Quran::Ayah.find(7), Quran::Surah.first.last_ayah
    assert_equal Quran::Ayah.find(293), Quran::Surah.second.last_ayah

    assert_equal Quran::Ayah.find(148), Quran::Juz.first.last_ayah
    assert_equal Quran::Ayah.find(259), Quran::Juz.second.last_ayah
  end

  test 'next_ayah' do
    assert_equal Quran::Ayah.second, quran_pages(:page_1).next_ayah

    quran_pages(:page_1).current_ayah = Quran::Ayah.find(7)
    assert_equal Quran::Ayah.first, quran_pages(:page_1).next_ayah

    quran_pages(:page_1).current_ayah = Quran::Ayah.find(3)
    assert_equal Quran::Ayah.find(4), quran_pages(:page_1).next_ayah
  end

  test 'next_ayah?' do
    assert quran_pages(:page_1).next_ayah?

    quran_pages(:page_1).current_ayah = Quran::Ayah.find(7)
    assert_not quran_pages(:page_1).next_ayah?

    quran_pages(:page_1).current_ayah = Quran::Ayah.find(3)
    assert quran_pages(:page_1).next_ayah?
  end
end
