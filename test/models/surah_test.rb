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
end
