# frozen_string_literal: true

require 'test_helper'

class JuzMemoryTest < ActiveSupport::TestCase
  test 'uniqueness of each account juz combination' do
    account = accounts(:abdullah)
    juz = juzs(:juz_1)
    assert JuzMemory.new(account: account, juz: juz).save
    assert_not JuzMemory.new(account: account, juz: juz).save
  end

  test 'after_save updates_total_memory_juz_count' do
    account = accounts(:abdullah)
    juz = juzs(:juz_1)
    JuzMemory.create(account: account, juz: juz, character_length: 23_322)
    assert_equal 1, account.memory_total.juz_count
  end
end
