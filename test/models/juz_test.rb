# frozen_string_literal: true

require 'test_helper'

class JuzTest < ActiveSupport::TestCase
  setup { @juz = Quran::Juz.first }

  test 'description' do
    assert_equal 'Al-Fatihah: 1 - Al-Baqarah: 141', Quran::Juz.first.description
  end

  test 'to_s' do
    assert_equal 'Juz 1', @juz.to_s
  end
end
