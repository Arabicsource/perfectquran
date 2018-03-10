# frozen_string_literal: true

# :nodoc:
class Memory < ApplicationRecord
  belongs_to :account
  belongs_to :ayah

  validates :ayah_id, uniqueness: { scope: :account_id }

  after_create :update_surah_memory
  after_create :update_page_memory
  after_create :update_juz_memory
  after_create :update_memory_total_characters

  private

  def update_surah_memory
    sm = SurahMemory.find_or_create_by(account: account, surah: ayah.surah)
    sm.character_length = sm.character_length.to_i + ayah.character_length
    sm.save
  end

  def update_page_memory
    pm = PageMemory.find_or_create_by(account: account, page: ayah.page)
    pm.character_length = pm.character_length.to_i + ayah.character_length
    pm.save
  end

  def update_juz_memory
    jm = JuzMemory.find_or_create_by(account: account, juz: ayah.juz)
    jm.character_length = jm.character_length.to_i + ayah.character_length
    jm.save
  end

  def update_memory_total_characters
    mt = MemoryTotal.find_or_create_by(account: account)
    mt.character_length = mt.character_length + ayah.character_length
    mt.save
  end
end
