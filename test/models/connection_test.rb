# frozen_string_literal: true

require 'test_helper'

class ConnectionTest < ActiveSupport::TestCase
  test 'hashtags' do
    connection = create_connection tag: '#Tag with Space'

    assert_equal '#TagwithSpace', connection.hashtags
  end

  test 'hashtags length too long' do
    connection = build_connection tag: 'a' * 60

    assert_not connection.valid?
  end

  test 'hashtags length valid' do
    connection = create_connection tag: 'a' * 59

    assert connection.valid?
  end

  private

  def create_connection(tag:)
    FactoryBot.create(
      :connection, hashtags: tag, translation: translations(:translation_1)
    )
  end

  def build_connection(tag:)
    FactoryBot.build(
      :connection, hashtags: tag, translation: translations(:translation_1)
    )
  end
end
