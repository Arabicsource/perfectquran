# frozen_string_literal: true

# :nodoc:
class JuzMemory < ApplicationRecord
  belongs_to :account
  belongs_to :juz

  validates :juz_id, uniqueness: { scope: :account_id }

  after_save :update_memory_total_juz_count

  private

  def update_memory_total_juz_count
    return unless character_length == juz.character_length
    memory_total = MemoryTotal.find_by(account: account)
    memory_total.update_attribute(:juz_count, memory_total.juz_count + 1)
  end
end
