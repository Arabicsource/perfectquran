require 'test_helper'

class JuzTest < ActiveSupport::TestCase
  setup { @juz = juzs(:juz_1) }

  test 'description' do
    skip
  end

  test 'to_s' do
    assert_equal 'Juz 1', @juz.to_s
  end
end