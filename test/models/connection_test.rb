# frozen_string_literal: true

require 'test_helper'

class ConnectionTest < ActiveSupport::TestCase
  test 'hashtags' do
    connection = FactoryBot.create :connection, hashtags: '#Tag with Space'

    assert_equal '#TagwithSpace', connection.hashtags
  end

  test 'hashtags length too long' do
    connection = FactoryBot.build :connection, hashtags: 'a' * 60

    assert_not connection.valid?
  end

  test 'hashtags length valid' do
    connection = FactoryBot.build :connection, hashtags: 'a' * 59

    assert connection.valid?
  end
end
