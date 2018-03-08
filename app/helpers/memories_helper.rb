# frozen_string_literal: true

# :nodoc:
module MemoriesHelper
  def memorized?(ayah, account)
    Memory.where(memorable: ayah, account: account).any?
  end

  def surah_memorized?(surah, account)
    ayah_ids = surah.ayahs.pluck :id
    memory_count = Memory.where(memorable: ayah_ids, account: account).count
    memory_count >= surah.number_of_ayahs
  end
end
