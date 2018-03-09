# frozen_string_literal: true

require 'test_helper'

class PageMemoryTest < ActiveSupport::TestCase
  test 'uniqueness of each account page combination' do
    account = accounts(:abdullah)
    page = pages(:page_1)
    assert PageMemory.new(account: account, page: page).save
    assert_not PageMemory.new(account: account, page: page).save
  end

  test 'after_save updates_total_memory_page_count' do
    account = accounts(:abdullah)
    page = pages(:page_1)
    PageMemory.create(account: account, page: page, character_length: 285)
    assert_equal 1, account.memory_total.page_count
  end
end
