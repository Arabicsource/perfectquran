# frozen_string_literal: true

# :nodoc:
class HifzManager
  attr_reader :not_memorized_surahs, :partially_memorized_surahs,
              :memorized_surahs

  def initialize(account)
    @account = account
    @not_memorized_surahs = []
    @partially_memorized_surahs = []
    @memorized_surahs = []
    build_surah_groups
  end

  def memory_length
    memorized_ayahs.sum(:character_length)
  end

  private

  def build_surah_groups
    Surah.all.each do |surah|
      memory_count = memories.where(ayah: surah.ayah_ids).count

      if memory_count.zero?
        @not_memorized_surahs << surah
      elsif memory_count >= surah.number_of_ayahs
        @memorized_surahs << surah
      else
        @partially_memorized_surahs << surah
      end
    end
  end

  def memorized_ayahs
    Ayah
      .left_outer_joins(:memories)
      .where(memories: { account: @account })
  end

  def memories
    Memory.where(account: @account)
  end
end
