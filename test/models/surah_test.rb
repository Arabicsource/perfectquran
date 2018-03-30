# frozen_string_literal: true

require 'test_helper'

class SurahTest < ActiveSupport::TestCase
  test 'description' do
    surah = Quran::Surah.first
    assert_equal 'The Opening - الفاتحة', surah.description
  end

  test 'to_s' do
    surah = Quran::Surah.first
    assert_equal 'Al-Fatihah', surah.to_s
  end

  test 'memorized?' do
    Current.account = accounts(:abdullah)
    surah = Quran::Surah.first
    sm = SurahMemory.create(
      account: Current.account, surah: surah, character_length: 55
    )
    assert_not surah.memorized?

    sm.update_attribute(:character_length, surah.character_length)
    assert surah.memorized?
  end

  test 'memorized_percentage' do
    Current.account = accounts(:abdullah)
    assert Quran::Surah.first.memorized_percentage.zero?

    ayahs(:ayah_1).memorize
    assert_equal 13.333333333333334, Quran::Surah.first.memorized_percentage
  end

  test 'memorize' do
    Current.account = accounts(:abdullah)
    assert Current.account.memories.count.zero?

    Quran::Surah.first.memorize
    assert_equal 7, Current.account.memories.count
  end
end
