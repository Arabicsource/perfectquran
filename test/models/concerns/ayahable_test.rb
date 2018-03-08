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
end
