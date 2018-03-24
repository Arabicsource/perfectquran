# frozen_string_literal: true

class Language < ApplicationRecord
  has_many :translations

  delegate :available_for_study, to: :translations, prefix: :translations

  scope :available_for_study, -> { joins(translations: :texts).uniq }
end
