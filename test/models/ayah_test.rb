require 'test_helper'

class AyahTest < ActiveSupport::TestCase
  test 'transliterated_text' do
    assert_equal texts(:transliteration_1).content, ayahs(:ayah_1).transliterated_text
  end
end