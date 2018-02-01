# frozen_string_literal: true

# :nodoc:
class HifzManager
  def initialize(account)
    @account = account
    @memories = Memory.where(account: account)
    @ayah_ids = @memories.map(&:ayah_id)
  end

  def memory_count
    Quran::Ayah.where(id: @ayah_ids).sum(:character_length)
  end

  def not_memorized_surahs
    not_memorized_surahs = []

    Quran::Surah.all.each do |surah|
      ayah_ids = surah.ayahs.pluck :id
      memory_count = Memory.where(ayah: ayah_ids, account: @account).count

      not_memorized_surahs << surah if memory_count.zero?
    end

    not_memorized_surahs
  end

  def partially_memorized_surahs
    partially_memorized_surahs = []

    Quran::Surah.all.each do |surah|
      ayah_ids = surah.ayahs.pluck :id
      memory_count = Memory.where(ayah: ayah_ids, account: @account).count

      if memory_count.positive? && memory_count < surah.number_of_ayahs
        partially_memorized_surahs << surah
      end
    end

    partially_memorized_surahs
  end

  def memorized_surahs
    memorized_surahs = []

    Quran::Surah.all.each do |surah|
      ayah_ids = surah.ayahs.pluck :id
      memory_count = Memory.where(ayah: ayah_ids, account: @account).count

      memorized_surahs << surah if memory_count >= surah.number_of_ayahs
    end

    memorized_surahs
  end
end
