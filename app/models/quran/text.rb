# frozen_string_literal: true

# == Schema Information
#
# Table name: texts
#
#  id             :integer          not null, primary key
#  content        :text
#  translation_id :integer
#  ayah_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

module Quran
  # :nodoc:
  class Text < ApplicationRecord
    searchkick

    default_scope { order('id asc') }

    belongs_to :translation, class_name: 'Quran::Translation'
    belongs_to :ayah

    def uthmani?
      translation_id == 1
    end
  end
end
