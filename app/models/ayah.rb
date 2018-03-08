# frozen_string_literal: true

class Ayah < ApplicationRecord
  default_scope { order('id asc') }

  belongs_to :surah
  belongs_to :page
  belongs_to :juz

  has_many :memories
  has_many :bookmarks, as: :bookmarkable
  has_many :texts
  has_many :texts_and_included_translations,
            -> { includes(:translation) },
            class_name: 'Text'

  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  def noble_quran_text
    texts.where(translation_id: 3).first.try(:content) || ''
  end

  def uthmani_text
    texts.where(translation_id: 1).first.try(:content) || ''
  end

  def transliterated_text
    texts.where(translation_id: 2).first.content
  end

  def surah_name
    surah.transliterated_name
  end

  def previous
    @previous ||= if id > 1
                    self.class.find_by id: id - 1
                  else
                    self.class.find_by id: 6236
                  end
  end

  def next
    if id == 6236
      self.class.find_by id: 1
    else
      self.class.find_by id: id + 1
    end
  end

  def to_s
    "#{surah_name}: #{number}"
  end
end
