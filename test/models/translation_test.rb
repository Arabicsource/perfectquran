# frozen_string_literal: true

require 'test_helper'

class TranslationTest < ActiveSupport::TestCase
  test 'available_for_study' do
    assert_equal [1, 2, 3], Quran::Translation.available_for_study.map(&:id)
  end
end
