# frozen_string_literal: true

# :nodoc:
class PageMemory < ApplicationRecord
  belongs_to :account
  belongs_to :page

  validates :page_id, uniqueness: { scope: :account_id }

  after_save :update_memory_total_page_count

  private

  def update_memory_total_page_count
    return unless character_length == page.character_length
    memory_total = MemoryTotal.find_by(account: account)
    memory_total.update_attribute(:page_count, memory_total.page_count + 1)
  end
end
