# frozen_string_literal: true

# == Schema Information
#
# Table name: texts
#
#  id             :bigint(8)        not null, primary key
#  content        :text
#  translation_id :bigint(8)
#  ayah_id        :bigint(8)
#

module Quran
  class Text < ApplicationRecord
    # default_scope { order('id asc') }

    belongs_to :translation
    belongs_to :ayah, class_name: 'Quran::Ayah'
    has_one :surah, through: :ayah

    def uthmani?
      translation_id == 1
    end

    def twitterize
      Twitterize.new(self).call
    end

    def reference
      "[#{surah.id}:#{ayah.number}]"
    end
  end
end
