# frozen_string_literal: true

class Surah < ApplicationRecord
  enum revelation_type: %i[meccan medinan]
  has_many :ayahs
  has_many :bookmarks, as: :bookmarkable
  has_many :ayahs_and_included_texts,
            -> { includes(:texts_and_included_translations) },
            class_name: 'Ayah'
  has_many :memories, through: :ayahs
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
end
