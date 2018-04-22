# frozen_string_literal: true

# == Schema Information
#
# Table name: languages
#
#  id        :bigint(8)        not null, primary key
#  name      :string
#  direction :string
#

module Quran
  class Language < ApplicationRecord
    has_many :translations

    delegate :available_for_study, to: :translations, prefix: :translations

    scope :available_for_study, -> { joins(translations: :texts).uniq }
  end
end
