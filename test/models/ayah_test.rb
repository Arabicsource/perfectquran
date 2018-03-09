require 'test_helper'

class AyahTest < ActiveSupport::TestCase
  test 'transliterated_text' do
    assert_equal texts(:transliteration_1).content, ayahs(:ayah_1).transliterated_text
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