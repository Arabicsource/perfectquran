# frozen_string_literal: true

require 'test_helper'

class SurahTest < ActiveSupport::TestCase
  test 'description' do
    surah = surahs(:surah_1)
    assert_equal 'The Opening - الفاتحة', surah.description
  end

  test 'to_s' do
    surah = surahs(:surah_1)
    assert_equal 'Al-Fatihah', surah.to_s
  end

  test 'memorized?' do
    Current.account = accounts(:abdullah)
    surah = surahs(:surah_1)
    sm = SurahMemory.create(
      account: Current.account, surah: surah, character_length: 55
    )
    assert_not surah.memorized?

    sm.update_attribute(:character_length, surah.character_length)
    assert surah.memorized?
  end

  test 'memorized_percentage' do
    Current.account = accounts(:abdullah)
    assert surahs(:surah_1).memorized_percentage.zero?

    ayahs(:ayah_1).memorize
    assert_equal 13.333333333333334, surahs(:surah_1).memorized_percentage
  end

  test 'memorize' do
    Current.account = accounts(:abdullah)
    assert Current.account.memories.count.zero?

    surahs(:surah_1).memorize
    assert_equal 7, Current.account.memories.count
  end
end
