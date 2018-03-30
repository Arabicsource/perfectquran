# frozen_string_literal: true

require 'test_helper'

class JuzTest < ActiveSupport::TestCase
  setup { @juz = Quran::Juz.first }

  test 'memorized?' do
    Current.account = accounts(:abdullah)
    juz = Quran::Juz.first
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

    Quran::Juz.first.memorize
    assert_equal 148, Current.account.memories.count
  end

  test 'memorized_percentage' do
    Current.account = accounts(:abdullah)
    assert Quran::Juz.first.memorized_percentage.zero?

    ayahs(:ayah_1).memorize
    assert_equal 0.1629362833376211, Quran::Juz.first.memorized_percentage
  end

  test 'description' do
    assert_equal 'Al-Fatihah: 1 - Al-Baqarah: 141', Quran::Juz.first.description
  end

  test 'to_s' do
    assert_equal 'Juz 1', @juz.to_s
  end
end
