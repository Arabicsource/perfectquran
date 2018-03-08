require 'test_helper'

class JuzTest < ActiveSupport::TestCase
  setup { @juz = juzs(:juz_1) }

  test 'ayahs' do
    assert_equal (1..148).to_a, juzs(:juz_1).ayahs.map(&:id)
  end

  test 'pages' do
    assert_equal (1..21).to_a, juzs(:juz_1).pages.map(&:id)
  end

  test 'first_page' do
    assert_equal pages(:page_1), @juz.first_page
    assert_equal pages(:page_22), juzs(:juz_2).first_page
  end

  test 'memorized?' do
    Current.account = accounts(:abdullah)
    juz = juzs(:juz_1)
    jm = JuzMemory.create(account: Current.account, juz: juz, character_length: 55)
    assert_not juz.memorized?

    jm.update_attribute(:character_length, juz.character_length)
    assert juz.memorized?
  end

  test 'description' do
    skip
  end

  test 'to_s' do
    assert_equal 'Juz 1', @juz.to_s
  end
end