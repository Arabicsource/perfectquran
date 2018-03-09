# frozen_string_literal: true

require 'test_helper'

class MemoryTest < ActiveSupport::TestCase
  test 'uniqueness of each account ayah combination' do
    account = accounts(:abdullah)
    ayah = ayahs(:ayah_1)
    assert Memory.new(account: account, ayah: ayah).save
    assert_not Memory.new(account: account, ayah: ayah).save
  end

  test 'after_create updates_surah_memory' do
    account = accounts(:abdullah)
    ayah = ayahs(:ayah_1)
    Memory.create(account: account, ayah: ayah)
    assert_equal(
      38, account.surah_memories.find_by(surah: ayah.surah).character_length
    )
  end

  test 'after_create updates_page_memory' do
    account = accounts(:abdullah)
    ayah = ayahs(:ayah_1)
    Memory.create(account: account, ayah: ayah)
    assert_equal(
      38, account.page_memories.find_by(page: ayah.page).character_length
    )
  end

  test 'after_create updates_juz_memory' do
    account = accounts(:abdullah)
    ayah = ayahs(:ayah_1)
    Memory.create(account: account, ayah: ayah)
    assert_equal(
      38, account.juz_memories.find_by(juz: ayah.juz).character_length
    )
  end

  test 'after_create update_memory_total_characters' do
    account = accounts(:abdullah)
    ayah = ayahs(:ayah_1)
    Memory.create(account: account, ayah: ayah)
    assert_equal 38, account.memory_total.character_length
  end
end
