# frozen_string_literal: true

require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test 'after_create memory_total is created' do
    account = Account.create!(email: 'new@perfectquran.co', password: 'passwd')
    assert_equal 1, MemoryTotal.where(account: account).count
  end
end
