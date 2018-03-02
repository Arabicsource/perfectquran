require 'test_helper'

class GuestAccountTest < ActiveSupport::TestCase
  setup { @account = GuestAccount.new }

  test 'patron?' do
    assert_not @account.patron?
  end
end