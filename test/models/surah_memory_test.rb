# frozen_string_literal: true

require 'test_helper'

class SurahMemoryTest < ActiveSupport::TestCase
  test 'uniqueness of each account surah combination' do
    account = accounts(:abdullah)
    surah = Quran::Surah.first
    assert SurahMemory.new(account: account, surah: surah).save
    assert_not SurahMemory.new(account: account, surah: surah).save
  end

  test 'after_create updates_total_memory' do
    account = accounts(:abdullah)
    surah = Quran::Surah.first
    SurahMemory.create(account: account, surah: surah, character_length: 285)
    assert_equal 1, account.memory_total.surah_count
  end
end
