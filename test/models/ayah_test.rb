# frozen_string_literal: true

require 'test_helper'

class AyahTest < ActiveSupport::TestCase
  test 'primary_text with guesst account' do
    Current.account = GuestAccount.new
    assert_equal 'Noble Quran 1', Quran::Ayah.first.primary_text
  end

  test 'primary_text with account without account_translations' do
    Current.account = FactoryBot.create :account
    assert_equal 'Noble Quran 1', Quran::Ayah.first.primary_text
  end

  test 'primary_text with account with account_translations' do
    skip
    Current.account = FactoryBot.create :account
    assert_equal 'Transliteration 1', Quran::Ayah.first.primary_text
  end

  test 'uthmani_text' do
    assert_equal 'Uthmani 1', Quran::Ayah.first.uthmani_text
  end

  test 'transliterated_text' do
    assert_equal 'Transliteration 1', Quran::Ayah.first.transliterated_text
  end

  test 'noble_quran_text' do
    assert_equal 'Noble Quran 1', Quran::Ayah.first.noble_quran_text
  end

  test 'surah_name' do
    assert_equal 'Al-Fatihah', Quran::Ayah.first.surah_name
  end

  test 'previous' do
    assert_equal Quran::Ayah.first, Quran::Ayah.second.previous
    assert_equal Quran::Ayah.last, Quran::Ayah.first.previous
  end

  test 'next' do
    assert_equal Quran::Ayah.second, Quran::Ayah.first.next
    assert_equal Quran::Ayah.first, Quran::Ayah.last.next
  end
end
