# frozen_string_literal: true

class SurahMemory < ApplicationRecord
  belongs_to :account
  belongs_to :surah, class_name: 'Quran::Surah'

  validates :surah_id, uniqueness: { scope: :account_id }

  after_save :update_memory_total_surah_count

  private

  def update_memory_total_surah_count
    return unless character_length == surah.character_length
    memory_total = MemoryTotal.find_by(account: account)
    memory_total.update_attribute(:surah_count, memory_total.surah_count + 1)
  end
end
