# frozen_string_literal: true

# == Schema Information
#
# Table name: translations
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  description :string
#  language_id :bigint(8)
#

module Quran
  class Translation < ApplicationRecord
    belongs_to :language, class_name: 'Quran::Language'

    has_many :texts, class_name: 'Quran::Text'
    has_many :account_translation

    scope :available_for_quran, -> { joins(:texts).order(:id).uniq }

    def self.available_for_posting
      where(id: [1, 3, 4])
    end
  end
end
