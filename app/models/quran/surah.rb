# frozen_string_literal: true

# == Schema Information
#
# Table name: quran_surahs
#
#  id                  :integer          not null, primary key
#  number_of_ayahs     :integer
#  order_of_revelation :integer
#  revelation_type     :integer
#  permalink           :string
#  transliterated_name :string
#  arabic_name         :string
#  english_name        :string
#  character_length    :integer
#  percent_of_total    :float
#

module Quran
  # :nodoc:
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
  end
end
