require 'test_helper'

class AyahableTest < ActiveSupport::TestCase
  # test 'ayahs' do
  #   assert_equal (1..7).to_a, quran_surahs(:surah_1).ayahs.map(&:id)
  #   assert_equal (1..7).to_a, quran_pages(:page_1).ayahs.map(&:id)
  #   assert_equal (1..148).to_a, quran_juzs(:juz_1).ayahs.map(&:id)
  # end

  # test 'each_ayah' do
  #   surah_1 = quran_surahs(:surah_1)
  #   assert_equal surah_1.ayahs.each.to_json, surah_1.each_ayah.to_json
  # end

  test 'first_ayah' do
    assert_equal ayahs(:ayah_1), pages(:page_1).first_ayah
  #   assert_equal quran_ayahs(:ayah_8), quran_surahs(:surah_2).first_ayah
  end

  # test 'last_ayah' do
  #   assert_equal quran_ayahs(:ayah_7), quran_surahs(:surah_1).last_ayah
  #   assert_equal quran_ayahs(:ayah_293), quran_surahs(:surah_2).last_ayah
  # end

  # test 'current_ayah?' do
  #   assert quran_surahs(:surah_1).current_ayah?(quran_ayahs(:ayah_1))
  #   assert_not quran_surahs(:surah_1).current_ayah?(quran_ayahs(:ayah_2))

  #   quran_surahs(:surah_1).current_ayah = quran_ayahs(:ayah_2)
  #   assert_not quran_surahs(:surah_1).current_ayah?(quran_ayahs(:ayah_1))
  #   assert quran_surahs(:surah_1).current_ayah?(quran_ayahs(:ayah_2))
  # end

  test 'current_ayah' do
    skip
    assert_equal ayahs(:ayah_1), pages(:page_1).current_ayah

  #   quran_surahs(:surah_1).current_ayah = quran_ayahs(:ayah_2)
  #   assert_equal quran_ayahs(:ayah_2), quran_surahs(:surah_1).current_ayah

  #   quran_surahs(:surah_1).current_ayah = quran_ayahs(:ayah_8)
  #   assert_equal quran_ayahs(:ayah_1), quran_surahs(:surah_1).current_ayah
  end

  # test 'next_ayah?' do
  #   assert quran_surahs(:surah_1).next_ayah?

  #   quran_surahs(:surah_1).current_ayah = quran_ayahs(:ayah_7)
  #   assert_not quran_surahs(:surah_1).next_ayah?
  # end

  # test 'previous_ayah?' do
  #   assert_not quran_surahs(:surah_1).previous_ayah?

  #   quran_surahs(:surah_1).current_ayah = quran_ayahs(:ayah_7)
  #   assert quran_surahs(:surah_1).previous_ayah?
  # end

  # test 'next_ayah' do
  #   assert_equal quran_ayahs(:ayah_2), quran_surahs(:surah_1).next_ayah

  #   quran_surahs(:surah_1).current_ayah = quran_ayahs(:ayah_7)
  #   assert_equal quran_ayahs(:ayah_1), quran_surahs(:surah_1).next_ayah
  # end

  # test 'previous_ayah' do
  #   assert_equal quran_ayahs(:ayah_7), quran_surahs(:surah_1).previous_ayah

  #   quran_surahs(:surah_1).current_ayah = quran_ayahs(:ayah_2)
  #   assert_equal quran_ayahs(:ayah_1), quran_surahs(:surah_1).previous_ayah
  # end
end
