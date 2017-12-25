# frozen_string_literal: true

# == Schema Information
#
# Table name: ayahs
#
#  id               :integer          not null, primary key
#  number           :integer
#  character_length :integer
#  percent_of_total :float
#  percent_of_surah :float
#  surah_id         :integer
#

module Quran
  # :nodoc:
  class Ayah < ApplicationRecord
    default_scope { order('id asc') }

    belongs_to :surah, class_name: 'Quran::Surah'
    has_many :memories
    has_many :texts, class_name: 'Quran::Text'
    has_many :texts_and_included_translations,
             -> { includes(:translation) },
             class_name: 'Quran::Text'

    def noble_quran_text
      texts.where(translation_id: 3).first.try(:content) || ''
    end

    def surah_name
      surah.transliterated_name
    end

    def previous?
      previous.present?
    end

    def previous
      @previous ||= if id > 1
                      self.class.find_by id: id - 1
                    else
                      self.class.find_by id: 6236
                    end
    end

    def next?
      self.next.present?
    end

    def next
      if id == 6236
        self.class.find_by id: 1
      else
        self.class.find_by id: id + 1
      end
    end
  end
end
