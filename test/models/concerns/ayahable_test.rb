require 'test_helper'

class AyahableTest < ActiveSupport::TestCase
  test 'ayahs' do
    assert_equal (1..7).to_a, pages(:page_1).ayahs.map(&:id)
  end

  test 'first_ayah' do
    assert_equal ayahs(:ayah_1), pages(:page_1).first_ayah
    assert_equal ayahs(:ayah_8), pages(:page_2).first_ayah
  end

  test 'current_ayah' do
    assert_equal ayahs(:ayah_1), pages(:page_1).current_ayah

    pages(:page_1).current_ayah = ayahs(:ayah_2)
    assert_equal ayahs(:ayah_2), pages(:page_1).current_ayah

    pages(:page_1).current_ayah = ayahs(:ayah_8)
    assert_equal ayahs(:ayah_1), pages(:page_1).current_ayah
  end

  test 'current_ayah?' do
    assert pages(:page_1).current_ayah?(ayahs(:ayah_1))
    assert_not pages(:page_1).current_ayah?(ayahs(:ayah_2))

    pages(:page_1).current_ayah = ayahs(:ayah_2)
    assert_not pages(:page_1).current_ayah?(ayahs(:ayah_1))
    assert pages(:page_1).current_ayah?(ayahs(:ayah_2))
  end

  test 'previous_ayah' do
    assert_equal ayahs(:ayah_7), pages(:page_1).previous_ayah

    pages(:page_1).current_ayah = ayahs(:ayah_7)
    assert_equal ayahs(:ayah_6), pages(:page_1).previous_ayah

    pages(:page_1).current_ayah = ayahs(:ayah_3)
    assert_equal ayahs(:ayah_2), pages(:page_1).previous_ayah
  end

  test 'previous_ayah?' do
    assert_not pages(:page_1).previous_ayah?

    pages(:page_1).current_ayah = ayahs(:ayah_7)
    assert pages(:page_1).previous_ayah?

    pages(:page_1).current_ayah = ayahs(:ayah_3)
    assert pages(:page_1).previous_ayah?
  end

  test 'last_ayah' do
    assert_equal ayahs(:ayah_7), pages(:page_1).last_ayah
    assert_equal ayahs(:ayah_12), pages(:page_2).last_ayah
  end

  test 'next_ayah' do
    assert_equal ayahs(:ayah_2), pages(:page_1).next_ayah

    pages(:page_1).current_ayah = ayahs(:ayah_7)
    assert_equal ayahs(:ayah_1), pages(:page_1).next_ayah

    pages(:page_1).current_ayah = ayahs(:ayah_3)
    assert_equal ayahs(:ayah_4), pages(:page_1).next_ayah
  end

  test 'next_ayah?' do
    assert pages(:page_1).next_ayah?

    pages(:page_1).current_ayah = ayahs(:ayah_7)
    assert_not pages(:page_1).next_ayah?

    pages(:page_1).current_ayah = ayahs(:ayah_3)
    assert pages(:page_1).next_ayah?
  end
end
