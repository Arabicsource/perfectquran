# frozen_string_literal: true

# :nodoc:
class Surah < ApplicationRecord
  enum revelation_type: %i[meccan medinan]
  has_many :ayahs
  has_many :bookmarks, as: :bookmarkable
  has_many :ayahs_and_included_texts,
           -> { includes(:texts_and_included_translations) },
           class_name: 'Ayah'
  has_many :memories, through: :ayahs
  has_many :pages, -> { distinct }, through: :ayahs

  def self.commonly_memorized
    where(id: 98..114).or(where(id: 1))
  end

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

  def first_page
    pages.first
  end

  def first_ayah
    ayahs.first
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
