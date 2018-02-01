# frozen_string_literal: true

# :nodoc:
class HifzManager
  def initialize(account)
    @account = account
    @memories = Memory.where(account: account)
    @ayah_ids = @memories.map(&:ayah_id)
    @not_memorized_surahs = []
    @partially_memorized_surahs = []
    @memorized_surahs = []
  end

  def memory_count
    Quran::Ayah.where(id: @ayah_ids).sum(:character_length)
  end

  def not_memorized_surahs
    group_surahs unless surahs_grouped?
    @not_memorized_surahs
  end

  def partially_memorized_surahs
    group_surahs unless surahs_grouped?
    @partially_memorized_surahs
  end

  def memorized_surahs
    group_surahs unless surahs_grouped?
    @memorized_surahs
  end

  private

  def surahs_grouped?
    @not_memorized_surahs.any? ||
    @partially_memorized_surahs.any? ||
    @memorized_surahs.any?
  end

  def group_surahs
    Quran::Surah.all.each do |surah|
      ayah_ids = surah.ayahs.pluck :id
      memory_count = Memory.where(ayah: ayah_ids, account: @account).count

      if memory_count.zero?
        @not_memorized_surahs << surah
      elsif memory_count >= surah.number_of_ayahs
        @memorized_surahs << surah
      else
        @partially_memorized_surahs << surah
      end
    end
  end
end
