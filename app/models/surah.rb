# frozen_string_literal: true

# :nodoc:
class Surah < ApplicationRecord
  include Ayahable

  include Pageable # depends on Ayahable

  enum revelation_type: %i[meccan medinan]
  has_many :bookmarks, as: :bookmarkable
  has_many :ayahs_and_included_texts,
           -> { includes(:texts_and_included_translations) },
           class_name: 'Ayah'
  has_many :memories, through: :ayahs

  # Returns the next surah if surah < surah.last.
  # If surah is last, returns first surah.
  def next
    if id < Surah.last.id
      self.class.find(id + 1)
    else
      self.class.first
    end
  end

  # Returns the previous surah if surah is > surah.first
  # If surah is first, returns last surah.
  def previous
    if id > Surah.first.id
      self.class.find(id - 1)
    else
      self.class.last
    end
  end

  def description
    "#{english_name} - #{arabic_name}"
  end

  def to_s
    transliterated_name
  end

  def memorized?
    character_length == surah_memory.character_length
  end

  def memorized_percentage
    (surah_memory.character_length / character_length.to_f) * 100
  end

  def memorize
    ayahs.each do |ayah|
      return false unless ayah.memorize
    end
  end

  private

  def surah_memory
    if Current.account.guest?
      SurahMemory.new
    else
      SurahMemory.find_or_initialize_by(account: Current.account, surah: self)
    end
  end
end
