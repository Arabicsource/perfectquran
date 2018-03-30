# frozen_string_literal: true

class Translation < ApplicationRecord
  belongs_to :language

  has_many :texts, class_name: 'Quran::Text'
  has_many :account_translation

  scope :available_for_study, -> { joins(:texts).order(:id).uniq }

  def self.available_for_posting
    where(id: [1, 3, 4])
  end
end
