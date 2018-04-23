# frozen_string_literal: true

# == Schema Information
#
# Table name: surahs
#
#  id                  :bigint(8)        not null, primary key
#  number_of_ayahs     :integer
#  order_of_revelation :integer
#  revelation_type     :integer
#  permalink           :string
#  transliterated_name :string
#  arabic_name         :string
#  english_name        :string
#  character_length    :integer
#

module Quran
  class Surah < ApplicationRecord
    include Ayahable

    include Pageable # depends on Ayahable

    default_scope { order :id }

    enum revelation_type: %i[meccan medinan]
    has_many :bookmarks, as: :bookmarkable
    has_many :ayahs_and_included_texts,
             -> { includes(:texts_and_translations) },
             class_name: 'Quran::Ayah'

    def next
      @next ||= if id < 114
                  self.class.find(id + 1)
                else
                  self.class.first
                end
    end

    def previous
      @previous ||= if id > 1
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

    def to_param
      permalink
    end
  end
end
