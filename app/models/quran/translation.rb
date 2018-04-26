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
    belongs_to :language

    has_many :account_translations
    has_many :texts

    scope :posting, -> { where(id: [1, 3, 4]) }
    scope :reading, -> { joins(:texts).order(:id).uniq }
  end
end
