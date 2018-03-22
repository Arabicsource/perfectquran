# frozen_string_literal: true

# :nodoc:
class Ayah < ApplicationRecord
  default_scope { order('id asc') }

  belongs_to :surah
  belongs_to :page
  belongs_to :juz

  has_many :memories
  has_many :bookmarks, as: :bookmarkable
  has_many :texts
  has_many :texts_and_translations,
           -> { includes(:translation) },
           class_name: 'Text'
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  def account_texts
    if Current.account.account_translations.any?
      texts.joins(translation: :account_translation)
           .order('account_translations.order ASC')
    else
      texts.where(translation: [1, 2, 3]).order(:id)
    end
  end

  def primary_text
    return noble_quran_text if Current.account.guest?

    primaries = Current.account.account_translations.where(primary: true)

    if primaries.any?
      primary = primaries.first.translation
      texts.where(translation: primary).first.content
    else
      noble_quran_text
    end
  end

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

  def memorize
    return false if Current.account.guest?
    Memory.create(account: Current.account, ayah: self)
  end

  def memorized?
    Memory.where(account: Current.account, ayah: self).any?
  end
end
