# frozen_string_literal: true

# == Schema Information
#
# Table name: quran_texts
#
#  id             :integer          not null, primary key
#  content        :text
#  translation_id :integer
#  ayah_id        :integer
#

module Quran
  # :nodoc:
  class Text < ApplicationRecord
    default_scope { order('id asc') }

    belongs_to :translation, class_name: 'Quran::Translation'
    belongs_to :ayah

    def uthmani?
      translation_id == 1
    end

    def twitterize
      Twitterize.new(self).call
    end
  end
end
