# frozen_string_literal: true

require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  test 'translations_available_for_study' do
    assert_equal(
      [2, 3],
      languages(:english).translations_available_for_study.map(&:id)
    )
  end

  test 'available_for_study' do
    assert_equal [1, 2], Language.available_for_study.map(&:id)
  end
end
