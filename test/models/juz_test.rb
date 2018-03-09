# frozen_string_literal: true

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
    jm = JuzMemory.create(
      account: Current.account, juz: juz, character_length: 55
    )
    assert_not juz.memorized?

    jm.update_attribute(:character_length, juz.character_length)
    assert juz.memorized?
  end

  test 'memorize' do
    Current.account = accounts(:abdullah)
    assert Current.account.memories.count.zero?

    juzs(:juz_1).memorize
    assert_equal 148, Current.account.memories.count
  end

  test 'memorized_percentage' do
    Current.account = accounts(:abdullah)
    assert juzs(:juz_1).memorized_percentage.zero?

    ayahs(:ayah_1).memorize
    assert_equal 0.1629362833376211, juzs(:juz_1).memorized_percentage
  end

  test 'description' do
    assert_equal 'Al-Fatihah: 1 - Al-Baqarah: 141', juzs(:juz_1).description
  end

  test 'to_s' do
    assert_equal 'Juz 1', @juz.to_s
  end
end
