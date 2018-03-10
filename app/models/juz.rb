# frozen_string_literal: true

# :nodoc:
class Juz < ApplicationRecord
  include Ayahable

  include Pageable # depends on Ayahable

  has_one :juz_memory

  def description
    "#{first_ayah.surah_name}: #{first_ayah.number}"\
    " - #{last_ayah.surah_name}: #{last_ayah.number}"
  end

  def to_s
    "Juz #{id}"
  end

  def memorized?
    character_length == juz_memory.character_length
  end

  def memorize
    ayahs.each do |ayah|
      return false unless ayah.memorize
    end
  end

  def memorized_percentage
    (juz_memory.character_length / character_length.to_f) * 100
  end

  private

  def juz_memory
    if Current.account.guest?
      JuzMemory.new
    else
      JuzMemory.find_or_initialize_by(account: Current.account, juz: self)
    end
  end
end
